require 'rails_helper'

RSpec.describe State, type: :model do
  it { is_expected.to have_many(:tasks).dependent(:restrict_with_error) }
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_inclusion_of(:state).in_array(State::STATES) }


  it "should get plain factory working" do
    f = FactoryBot.create(:state)
    g = FactoryBot.create(:state)
    expect(f).to validate_uniqueness_of(:name).case_insensitive
    expect(f).to be_valid
    expect(g).to be_valid
  end

  it "to_s returns value" do
    f = FactoryBot.create(:state, name: "Themenspeicher", state: "pre")
    expect("#{f}").to match ("Themenspeicher")
  end


end
