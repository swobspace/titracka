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
  include_context "time_accounting variables"
  let(:time_accountings) { TimeAccounting.all }

  # check for class methods
  it { expect(TimeAccountingQuery.respond_to? :new).to be_truthy}

  it "raise an ArgumentError" do
  expect {
    TimeAccountingQuery.new
  }.to raise_error(ArgumentError)
  end

 # check for instance methods
  describe "instance methods" do
    subject { TimeAccountingQuery.new(time_accountings) }
    it { expect(subject.respond_to? :all).to be_truthy}
    it { expect(subject.respond_to? :find_each).to be_truthy}
    it { expect(subject.respond_to? :include?).to be_truthy }
  end

 context "with unknown option :fasel" do
    subject { TimeAccountingQuery.new(time_accountings, {fasel: 'blubb'}) }
    describe "#all" do
      it "raises a argument error" do
        expect { subject.all }.to raise_error(ArgumentError)
      end
    end
  end

  context "with :user_id" do
    subject { TimeAccountingQuery.new(time_accountings, {user_id: mmax.id}) }
    before(:each) do
      @matching = [ta11, ta12]
      @nonmatching = [ta21, ta22]
    end
    it_behaves_like "a time_accounting query"
  end # :user_id mmax.id

  context "with :user" do
    subject { TimeAccountingQuery.new(time_accountings, {user: 'caro'}) }
    before(:each) do
      @matching = [ta21, ta22]
      @nonmatching = [ta11, ta12]
    end
    it_behaves_like "a time_accounting query"
  end # :user 'caro'

  context "with :date Date.yesterday" do
    subject { TimeAccountingQuery.new(time_accountings, {date: Date.yesterday}) }
    before(:each) do
      @matching = [ta11, ta21]
      @nonmatching = [ta12, ta22]
    end
    it_behaves_like "a time_accounting query"
  end # :user 'caro'


  describe "#all" do
    context "using :search'" do
      it "searches for sn" do
        search = TimeAccountingQuery.new(time_accountings, {search: 'max'})
        expect(search.all).to contain_exactly(ta11, ta12)
      end
    end
  end
end
