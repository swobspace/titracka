require "rails_helper"
require "cancan/matchers"

RSpec.describe TasksHelper, :type => :helper do
  include Devise::Test::ControllerHelpers
  let(:owner) { FactoryBot.create(:user, 
    sn: "Mustergirl", 
    givenname: "Caro", 
    email: "mcaro@mustermann.de"
  )}
  let(:responsible) { FactoryBot.create(:user, 
    sn: "Musterman", 
    givenname: "Max",
    email: ""
  )}

  describe "#raci" do
    let(:task) { FactoryBot.create(:task, user: owner, responsible: responsible) }
    subject { Capybara.string(helper.raci(task)) }
    it "shows responsible enclosed in <span>" do
      expect(subject.find("span.owner").text).to match("Mustergirl, Caro")
      expect(subject.find("span.responsible").text).to match("Musterman, Max")
    end
  end

  describe "#timeline" do
    subject { Capybara.string(helper.timeline(task, full: true)) }
    describe "only start set" do
      let(:task) { FactoryBot.create(:task, :open, start: 1.day.before(Date.today)) }
      it { expect(subject.find("span.start.active").text).to match(1.day.before(Date.today).to_s) }
    end
    describe "only deadline set" do
      let(:task) { FactoryBot.create(:task, :open, deadline: 1.day.before(Date.today)) }
      it { expect(subject.find("span.deadline.overdue").text).to match(1.day.before(Date.today).to_s) }
    end
    describe "start and deadline set" do
      let(:task) { FactoryBot.create(:task, :open, start: 1.day.before(Date.today), deadline: 1.day.after(Date.today)) }
      it { expect(subject.find("span.start.landing").text).to match(1.day.before(Date.today).to_s) }
      it { expect(subject.find("span.deadline.landing").text).to match(1.day.after(Date.today).to_s) }
    end
  end

  describe "#mailadresses_for_select" do
    let(:task) { FactoryBot.create(:task, user: owner, responsible: responsible) }
    subject { helper.mailaddresses_for_select(task) }
    before(:each) do
      expect(Titracka).to receive(:mail_to).and_return(["tracker@example.org"])
    end

    it "delivers array of email adresses" do
      expect(subject).to be_kind_of Array
      expect(subject).to contain_exactly("tracker@example.org", "mcaro@mustermann.de")
    end
  end

end
