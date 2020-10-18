require 'rails_helper'

RSpec.describe Workday, type: :model do
  it { is_expected.to belong_to(:user) }
  it { is_expected.to have_many(:time_accountings).with_primary_key(:date).with_foreign_key(:date) }
  it { is_expected.to validate_presence_of(:date) }
  it { is_expected.to validate_presence_of(:user_id) }

  it "should get plain factory working" do
    f = FactoryBot.create(:workday)
    g = FactoryBot.create(:workday)
    is_expected.to validate_uniqueness_of(:date).scoped_to(:user_id)
    expect(f).to be_valid
    expect(g).to be_valid
  end

  it "to_s returns value" do
    f = FactoryBot.create(:workday, date: "2020-04-05" )
    expect("#{f}").to match ("2020-04-05")
  end

end
