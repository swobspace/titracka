require 'rails_helper'

RSpec.describe TaskDecorator do
  let(:ou) { FactoryBot.create(:org_unit, name: "ACME Ltd") }
  let(:plain_list) { FactoryBot.create(:list, name: "Plain List") }
  let(:ou_list) { FactoryBot.create(:list, name: "OU List", org_unit: ou) }

  let(:decorated) { decorated = task.decorate }

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
    describe "start == today - 20days" do
      let(:task) { FactoryBot.create(:task, :open, start: 20.days.before(Date.today)) }
      it { expect(decorated.phase).to eq("listed") }
    end
    describe "start == today - 5days" do
      let(:task) { FactoryBot.create(:task, :open, start: 5.days.before(Date.today)) }
      it { expect(decorated.phase).to eq("starting") }
    end
    describe "start == today + 5days" do
      let(:task) { FactoryBot.create(:task, :open, start: 5.days.after(Date.today)) }
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

  end

end
