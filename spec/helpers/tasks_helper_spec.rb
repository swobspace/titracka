require "rails_helper"
require "cancan/matchers"

RSpec.describe TasksHelper, :type => :helper do
  include Devise::Test::ControllerHelpers
  let(:owner) { FactoryBot.create(:user, sn: "Mustergirl", givenname: "Caro") }
  let(:responsible) { FactoryBot.create(:user, sn: "Musterman", givenname: "Max") }

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
end
