require 'rails_helper'

RSpec.describe Workday, type: :model do
  it { is_expected.to belong_to(:user) }
  it { is_expected.to validate_presence_of(:date) }
  it { is_expected.to validate_presence_of(:user_id) }

  it "should get plain factory working" do
    f = FactoryBot.create(:workday)
    g = FactoryBot.create(:workday)
    expect(f).to be_valid
    expect(g).to be_valid
  end

  it "to_s returns value" do
    f = FactoryBot.create(:workday, date: "2020-04-05" )
    expect("#{f}").to match ("2020-04-05")
  end

end
