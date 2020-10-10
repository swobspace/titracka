require 'rails_helper'

RSpec.describe Task, type: :model do
  it { is_expected.to belong_to(:responsible).optional }
  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:org_unit).optional }
  it { is_expected.to belong_to(:list).optional }
  it { is_expected.to have_many(:time_accountings) }
  it { is_expected.to validate_presence_of(:subject) }
  it { is_expected.to validate_presence_of(:priority) }
  it { is_expected.to validate_presence_of(:user_id) }
  it { is_expected.to validate_presence_of(:state_id) }

  it "should get plain factory working" do
    f = FactoryBot.create(:task)
    g = FactoryBot.create(:task)
    expect(f).to be_valid
    expect(g).to be_valid
  end

  it "to_s returns value" do
    f = FactoryBot.create(:task, subject: "Some Task")
    expect("#{f}").to match ("Some Task")
  end
end
