require 'rails_helper'

RSpec.shared_examples "a time_accounting query" do
  describe "#all" do
    it { expect(subject.all).to contain_exactly(*@matching) }
  end
  describe "#find_each" do
    it "iterates over matching events" do
      a = []
      subject.find_each do |act|
        a << act
      end
      expect(a).to contain_exactly(*@matching)
    end
  end
  describe "#include?" do
    it "includes only matching events" do
      @matching.each do |ma|
        expect(subject.include?(ma)).to be_truthy
      end
      @nonmatching.each do |noma|
        expect(subject.include?(noma)).to be_falsey
      end
    end
  end
end

RSpec.describe TimeAccountingQuery do
  # include_context "time_accounting variables"
  fixtures 'wobauth/users', :states, :tasks, :time_accountings
  let(:ta11) { time_accountings(:ta11) }
  let(:ta12) { time_accountings(:ta12) }
  let(:ta13) { time_accountings(:ta13) }
  let(:ta21) { time_accountings(:ta21) }
  let(:ta22) { time_accountings(:ta22) }
  let(:timeaccountings) { TimeAccounting.joins(:task).all }

  # check for class methods
  it { expect(TimeAccountingQuery.respond_to? :new).to be_truthy}

  it "raise an ArgumentError" do
  expect {
    TimeAccountingQuery.new
  }.to raise_error(ArgumentError)
  end

 # check for instance methods
  describe "instance methods" do
    subject { TimeAccountingQuery.new(timeaccountings) }
    it { expect(subject.respond_to? :all).to be_truthy}
    it { expect(subject.respond_to? :find_each).to be_truthy}
    it { expect(subject.respond_to? :include?).to be_truthy }
  end

 context "with unknown option :fasel" do
    subject { TimeAccountingQuery.new(timeaccountings, {fasel: 'blubb'}) }
    describe "#all" do
      it "raises a argument error" do
        expect { subject.all }.to raise_error(ArgumentError)
      end
    end
  end

  context "with :user_id" do
    subject { TimeAccountingQuery.new(timeaccountings, {user_id: wobauth_users(:mmax).id}) }
    before(:each) do
      @matching = [ta11, ta12, ta13]
      @nonmatching = [ta21, ta22]
    end
    it_behaves_like "a time_accounting query"
  end # :user_id mmax.id

  context "with :user" do
    subject { TimeAccountingQuery.new(timeaccountings, {user: 'caro'}) }
    before(:each) do
      @matching = [ta21, ta22]
      @nonmatching = [ta11, ta12, ta13]
    end
    it_behaves_like "a time_accounting query"
  end # :user 'caro'

  context "with :date Date.yesterday" do
    subject { TimeAccountingQuery.new(timeaccountings, {date: Date.yesterday}) }
    before(:each) do
      @matching = [ta11, ta13, ta21]
      @nonmatching = [ta12, ta22]
    end
    it_behaves_like "a time_accounting query"
  end # :date

  context "with :newer Date.yesterday" do
    subject { TimeAccountingQuery.new(timeaccountings, {newer: Date.yesterday}) }
    before(:each) do
      @matching = [ta11, ta13, ta21]
      @nonmatching = [ta12, ta22]
    end
    it_behaves_like "a time_accounting query"
  end # :newer

  context "with :older Date.current -2" do
    subject { TimeAccountingQuery.new(timeaccountings, {older: 2.days.before(Date.current)}) }
    before(:each) do
      @matching = [ta12, ta22]
      @nonmatching = [ta11, ta13, ta21]
    end
    it_behaves_like "a time_accounting query"
  end # :older

  context "with :older Date.current -2 and :newer Date.current -6" do
    subject { TimeAccountingQuery.new(timeaccountings, {
                older: 2.days.before(Date.current),
                newer: 6.days.before(Date.current),
              }) }
    before(:each) do
      @matching = [ta12]
      @nonmatching = [ta11, ta13, ta21, ta22]
    end
    it_behaves_like "a time_accounting query"
  end # :newer, :older

  context "with :duration 75" do
    subject { TimeAccountingQuery.new(timeaccountings, {duration: 75}) }
    before(:each) do
      @matching = [ta13]
      @nonmatching = [ta11, ta12, ta21, ta22]
    end
    it_behaves_like "a time_accounting query"
  end # :duration  

  context "with :formatted_duration 01:15" do
    subject { TimeAccountingQuery.new(timeaccountings, {formatted_duration: '01:15'}) }
    before(:each) do
      @matching = [ta13]
      @nonmatching = [ta11, ta12, ta21, ta22]
    end
    it_behaves_like "a time_accounting query"
  end # :formatted_duration  

  context "with :description special activity" do
    subject { TimeAccountingQuery.new(timeaccountings, {description: 'special activity'}) }
    before(:each) do
      @matching = [ta21]
      @nonmatching = [ta11, ta12, ta13, ta22]
    end
    it_behaves_like "a time_accounting query"
  end # :description  

  context "with :task maxs task" do
    subject { TimeAccountingQuery.new(timeaccountings, {task: 'max'}) }
    before(:each) do
      @matching = [ta11, ta12, ta13]
      @nonmatching = [ta21, ta22]
    end
    it_behaves_like "a time_accounting query"
  end # :task  

  describe "#all" do
    context "using :search'" do
      it "searches for sn" do
        search = TimeAccountingQuery.new(timeaccountings, {search: 'max'})
        expect(search.all).to contain_exactly(ta11, ta12, ta13)
      end
    end
  end
end
