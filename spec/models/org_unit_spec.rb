require 'rails_helper'

RSpec.describe OrgUnit, type: :model do
  it { is_expected.to have_many(:lists).dependent(:restrict_with_error) }
  it { is_expected.to have_many(:tasks).dependent(:restrict_with_error) }
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to have_rich_text(:description) }

  it "should get plain factory working" do
    f = FactoryBot.create(:org_unit)
    g = FactoryBot.create(:org_unit)
    expect(f).to be_valid
    expect(g).to be_valid
  end

  it "to_s returns value" do
    f = FactoryBot.create(:org_unit, name: "ACME Ltd")
    expect("#{f}").to match ("ACME Ltd")
  end


end
