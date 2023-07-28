require 'rails_helper'

RSpec.describe List, type: :model do
  it { is_expected.to have_many(:tasks).dependent(:restrict_with_error) }
  it { is_expected.to belong_to(:org_unit).optional }
  it { is_expected.to belong_to(:user) }
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:user_id) }
  it { is_expected.to have_rich_text(:description) }

  it "should get plain factory working" do
    f = FactoryBot.create(:list)
    g = FactoryBot.create(:list)
    expect(f).to be_valid
    expect(g).to be_valid
  end

  it "to_s returns value" do
    f = FactoryBot.create(:list, name: "Themenspeicher")
    expect("#{f}").to match ("Themenspeicher")
  end


end
