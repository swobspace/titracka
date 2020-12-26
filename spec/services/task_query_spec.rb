require 'rails_helper'

RSpec.shared_examples "a task query" do
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

RSpec.describe TaskQuery do
  include_context "task variables"
  let(:tasks) { Task.all }

  # check for class methods
  it { expect(TaskQuery.respond_to? :new).to be_truthy}

  it "raise an ArgumentError" do
  expect {
    TaskQuery.new
  }.to raise_error(ArgumentError)
  end

 # check for instance methods
  describe "instance methods" do
    subject { TaskQuery.new(tasks) }
    it { expect(subject.respond_to? :all).to be_truthy}
    it { expect(subject.respond_to? :find_each).to be_truthy}
    it { expect(subject.respond_to? :include?).to be_truthy }
  end

 context "with unknown option :fasel" do
    subject { TaskQuery.new(tasks, {fasel: 'blubb'}) }
    describe "#all" do
      it "raises a argument error" do
        expect { subject.all }.to raise_error(ArgumentError)
      end
    end
  end

  context "with :responsible_id" do
    subject { TaskQuery.new(tasks, {responsible_id: mcaro.id}) }
    before(:each) do
      @matching = [t2, archiv2]
      @nonmatching = [t1, to1, to2, tl1, tl2, done1]
    end
    it_behaves_like "a task query"
  end # :responsible_id mcaro.id

  context "with :user_id" do
    subject { TaskQuery.new(tasks, {user_id: mmax.id}) }
    before(:each) do
      @matching = [t1, to1]
      @nonmatching = [t2, to2, tl1, tl2, done1, archiv2]
    end
    it_behaves_like "a task query"
  end # :user_id mmax.id

  context "with :user" do
    subject { TaskQuery.new(tasks, {user: 'caro'}) }
    before(:each) do
      @matching = [t2, to2]
      @nonmatching = [t1, to1, tl1, tl2, done1, archiv2]
    end
    it_behaves_like "a task query"
  end # :user 'caro'

  context "with :start 2020-02" do
    subject { TaskQuery.new(tasks, {start: "2020-02"}) }
    before(:each) do
      @matching = [tl1]
      @nonmatching = [t1, t2, to1, to2, tl2, done1, archiv2]
    end
    it_behaves_like "a task query"
  end # :start 2020-02

  context "with :resubmission 2020-07" do
    subject { TaskQuery.new(tasks, {resubmission: "2020-07"}) }
    before(:each) do
      @matching = [t1]
      @nonmatching = [t2, to1, to2, tl1, tl2, done1, archiv2]
    end
    it_behaves_like "a task query"
  end # :resubmission 2020-07

  context "with :deadline 2020-12" do
    subject { TaskQuery.new(tasks, {deadline: "2020-12"}) }
    before(:each) do
      @matching = [tl2]
      @nonmatching = [t1, t2, to1, to2, tl1, done1, archiv2]
    end
    it_behaves_like "a task query"
  end # :deadline 2020-12

  context "with :from_deadline 2020-08-01" do
    subject { TaskQuery.new(tasks, {from_deadline: "2020-08-01"}) }
    before(:each) do
      @matching = [t1, tl2]
      @nonmatching = [t2, to1, to2, tl1, done1, archiv2]
    end
    it_behaves_like "a task query"
  end # :from_deadline 2020-08-01

  context "with :to_start 2020-08-01" do
    subject { TaskQuery.new(tasks, {to_start: "2020-08-01"}) }
    before(:each) do
      @matching = [tl1, tl2]
      @nonmatching = [t1, t2, to1, to2, done1, archiv2]
    end
    it_behaves_like "a task query"
  end # :to_start 2020-08-01


  context "with :subject mm" do
    subject { TaskQuery.new(tasks, {subject: 'mm'}) }
    before(:each) do
      @matching = [to1, tl1]
      @nonmatching = [t1, t2, to2, tl2, done1, archiv2]
    end
    it_behaves_like "a task query"
  end # :subject mm

  describe "#all" do
    context "using :search'" do
      it "searches for sn" do
        search = TaskQuery.new(tasks, {search: 'max'})
        expect(search.all).to contain_exactly(t1, to1)
      end
    end
  end
end
