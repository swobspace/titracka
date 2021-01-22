require 'rails_helper'

RSpec.describe RecentTasksQuery do
  let(:user) { FactoryBot.create(:user) }
  # check for class methods
  it { expect(RecentTasksQuery.respond_to? :new).to be_truthy}

  it "raise an ArgumentError" do
  expect {
    RecentTasksQuery.new
  }.to raise_error(KeyError)
  end

 # check for instance methods
  describe "instance methods" do
    subject { RecentTasksQuery.new(user_id: 2) }
    it { expect(subject.respond_to? :tasks).to be_truthy}
  end

 context "with unknown option :fasel" do
    subject { RecentTasksQuery.new(user_id: 2, fasel: 'blubb') }
    describe "#tasks" do
      it "raises a argument error" do
        expect { subject.tasks }.to raise_error(ArgumentError)
      end
    end
  end

  context "with time_accountings" do
    let(:t1) { FactoryBot.create(:task, user: user) }
    let(:t2) { FactoryBot.create(:task, user: user) }
    let(:t3) { FactoryBot.create(:task, user: user) }
    let(:t4) { FactoryBot.create(:task, user: user) }
    let!(:ta11) { FactoryBot.create(:time_accounting, task: t1, user: user, 
                                    date: 1.day.before(Date.today)) }
    let!(:ta12) { FactoryBot.create(:time_accounting, task: t1, user: user, 
                                    date: 1.week.before(Date.today)) }
    let!(:ta13) { FactoryBot.create(:time_accounting, task: t1, user: user, 
                                    date: 1.month.before(Date.today)) }
    let!(:ta21) { FactoryBot.create(:time_accounting, task: t2, user: user, 
                                    date: 3.weeks.before(Date.today)) }
    let!(:ta22) { FactoryBot.create(:time_accounting, task: t2, user: user, 
                                    date: 3.weeks.before(Date.today)) }
    let!(:ta31) { FactoryBot.create(:time_accounting, task: t3, user: user, 
                                    date: Date.today) }
    let!(:ta41) { FactoryBot.create(:time_accounting, task: t4, user: user, 
                                    date: 6.weeks.before(Date.today)) }
    subject { RecentTasksQuery.new(user_id: user.id) }

    it { expect(subject.tasks[0]).to eq(t1) }
    it { expect(subject.tasks[1]).to eq(t3) }
    it { expect(subject.tasks[2]).to eq(t2) }
  end

end
