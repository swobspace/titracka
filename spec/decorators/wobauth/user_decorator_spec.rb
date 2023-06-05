require 'rails_helper'

RSpec.describe Wobauth::UserDecorator do
  fixtures 'wobauth/users'

  let(:user) { wobauth_users(:mmax) }
  let!(:ta1) { FactoryBot.create(:time_accounting, 
    user: user, 
    date: '2021-01-04',
    duration: 110
  )}
  let!(:ta2) { FactoryBot.create(:time_accounting, 
    user: user, 
    date: '2021-01-05',
    duration: 120
  )}
  let!(:ta3) { FactoryBot.create(:time_accounting, 
    user: user, 
    date: '2021-01-06',
    duration: 130
  )}
  let!(:ta4) { FactoryBot.create(:time_accounting, 
    user: user, 
    date: '2021-01-07',
    duration: 140
  )}
  let!(:ta5) { FactoryBot.create(:time_accounting, 
    user: user, 
    date: '2021-01-08',
    duration: 150
  )}
  let!(:ta6) { FactoryBot.create(:time_accounting, 
    user: user, 
    date: '2021-01-09',
    duration: 160
  )}
  let(:decorated) { decorated = user.decorate }

  context "with all attributes set" do
    describe "#shortname" do
      it { expect(decorated.shortname).to eq ("Mustermann, Max") }
    end
  end

  context "without any user attributes" do
    let(:user) { FactoryBot.create(:user, username: "tmax") }
    describe "#shortname" do
      it { expect(decorated.shortname).to eq ("tmax") }
    end
  end

  describe "#working_time" do
    context "with option :day" do
      it { expect(decorated.working_time(day: '2021-01-04')).to eq(110) }
      it { expect(decorated.working_time(day: '2021-01-09')).to eq(160) }
    end
    context "with option :week" do
      it { expect(decorated.working_time(week: '2021-01-07')).to eq(810) }
    end
  end
end
