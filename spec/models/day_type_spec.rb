require 'rails_helper'

RSpec.describe DayType, type: :model do
  it { is_expected.to have_many(:workdays).dependent(:restrict_with_error) }

  it { is_expected.to validate_presence_of(:abbrev) }

  it "should get plain factory working" do
    f = FactoryBot.create(:day_type)
    g = FactoryBot.create(:day_type)
    expect(f).to be_valid
    expect(g).to be_valid
    expect(f).to validate_uniqueness_of(:abbrev).case_insensitive
  end

  it "to_s returns value" do
    f = FactoryBot.create(:day_type, abbrev: "K", description: "Krankmeldung")
    expect("#{f}").to match ("K")
  end


end
