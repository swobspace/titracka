require 'rails_helper'

RSpec.describe TaskDecorator do
  let(:ou) { FactoryBot.create(:org_unit, name: "ACME Ltd") }
  let(:plain_list) { FactoryBot.create(:list, name: "Plain List") }
  let(:ou_list) { FactoryBot.create(:list, name: "OU List", org_unit: ou) }

  let(:decorated) { decorated = task.decorate }

  before do
    Timecop.freeze(Time.local(2021))
  end
  after do
    Timecop.return
  end

  describe "#name_with_list_or_org_unit" do
    describe "task with org_unit and list" do
      let(:task) { FactoryBot.create(:task, list: ou_list, subject: "MySubject") }
      it { expect(decorated.name_with_list_or_org_unit).to eq("ACME Ltd / OU List / MySubject") }
    end
    describe "task with org_unit" do
      let(:task) { FactoryBot.create(:task, org_unit: ou, subject: "MySubject") }
      it { expect(decorated.name_with_list_or_org_unit).to eq("ACME Ltd / MySubject") }
    end
    describe "task with list" do
      let(:task) { FactoryBot.create(:task, list: plain_list, subject: "MySubject") }
      it { expect(decorated.name_with_list_or_org_unit).to eq("Plain List / MySubject") }
    end
    describe "task without ou or list" do
      let(:task) { FactoryBot.create(:task, subject: "MySubject") }
      it { expect(decorated.name_with_list_or_org_unit).to eq("MySubject") }
    end
  end

  describe "#phase" do
    describe "start, deadline == nil" do
      let(:task) { FactoryBot.create(:task, :open) }
      it { expect(decorated.phase).to eq("active") }
    end
    describe "start == today + 20days" do
      let(:task) { FactoryBot.create(:task, :open, start: 20.days.after(Date.today)) }
      it { expect(decorated.phase).to eq("listed") }
    end
    describe "start == today + 5days" do
      let(:task) { FactoryBot.create(:task, :open, start: 5.days.after(Date.today)) }
      it { expect(decorated.phase).to eq("starting") }
    end
    describe "start == today - 5days" do
      let(:task) { FactoryBot.create(:task, :open, start: 5.days.before(Date.today)) }
      it { expect(decorated.phase).to eq("active") }
    end
    describe "start == today" do
      let(:task) { FactoryBot.create(:task, :open, start: Date.today) }
      it { expect(decorated.phase).to eq("active") }
    end

    describe "deadline == today + 20 days" do
      let(:task) { FactoryBot.create(:task, :open, deadline: 20.days.after(Date.today)) }
      it { expect(decorated.phase).to eq("active") }
    end
    describe "deadline == today + 5 days" do
      let(:task) { FactoryBot.create(:task, :open, deadline: 5.days.after(Date.today)) }
      it { expect(decorated.phase).to eq("landing") }
    end
    describe "deadline == yesterday" do
      let(:task) { FactoryBot.create(:task, :open, deadline: Date.yesterday) }
      it { expect(decorated.phase).to eq("overdue") }
    end
    describe "deadline == yesterday, but closed" do
      let(:task) { FactoryBot.create(:task, :done, deadline: Date.yesterday) }
      it { expect(decorated.phase).to eq("inactive") }
    end

  end

  describe "#statistics" do
    let(:owner)   { FactoryBot.create(:user) }
    let(:foreign)   { FactoryBot.create(:user) }
    let(:task) { FactoryBot.create(:task, :open)}
    let!(:t1) { FactoryBot.create(:time_accounting,
      task: task,
      user: owner,
      duration: 4,
      date: "2019-11-04"
    )}
    let!(:t2) { FactoryBot.create(:time_accounting,
      task: task,
      user: owner,
      duration: 8,
      date: "2020-11-04"
    )}
    let!(:t3) { FactoryBot.create(:time_accounting,
      task: task,
      user: foreign,
      duration: 16,
      date: "2020-11-04"
    )}
    let!(:t4) { FactoryBot.create(:time_accounting,
      task: task,
      user: owner,
      duration: 32,
      date: "2020-11-30"
    )}
    let!(:t5) { FactoryBot.create(:time_accounting,
      task: task,
      user: owner,
      duration: 64,
      date: "2021-01-04"
    )}

    it { expect(decorated.statistics).to eq(["2020", "11"] => 56, ["2021", "01"] => 64)}

    it { expect(decorated.statistics(user: owner)).to eq(["2020", "11"] => 40, ["2021", "01"] => 64)}
    it { expect(decorated.statistics(resolution: 'year')).to eq("2020" => 56, "2021" => 64)}
  end

end
