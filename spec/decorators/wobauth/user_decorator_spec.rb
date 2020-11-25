require 'rails_helper'

RSpec.describe Wobauth::UserDecorator do

  let(:user) { FactoryBot.create(:user, 
    sn: "Mustermann", 
    givenname: "Max", 
    username: "mmax",
    title: "Dr.",
    email: "max.mustermann@example.com",
    displayname: "Max Mustermanns display name",
    department: "Max Mustermanns department",
    company: "Mustermann GmbH",
  )} 
  let(:decorated) { decorated = user.decorate }

  context "with all attributes set" do
    describe "#shortname" do
      it { expect(decorated.shortname).to eq ("Mustermann, Max") }
    end
  end

  context "without any user attributes" do
    let(:user) { FactoryBot.create(:user, username: "mmax") }
    describe "#shortname" do
      it { expect(decorated.shortname).to eq ("mmax") }
    end
  end
end
