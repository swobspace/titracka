require 'rails_helper'

RSpec.describe Reference, type: :model do
  it { is_expected.to have_many(:cross_references).dependent(:restrict_with_error) }
  it { is_expected.to have_many(:reference_urls).dependent(:delete_all) }
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:identifier_name) }
  it { is_expected.to accept_nested_attributes_for(:reference_urls).allow_destroy(true) }

  it "should get plain factory working" do
    f = FactoryBot.create(:reference)
    g = FactoryBot.create(:reference)
    expect(f).to validate_uniqueness_of(:name).case_insensitive
    expect(f).to be_valid
    expect(g).to be_valid
  end

  it "to_s returns value" do
    f = FactoryBot.create(:reference, name: "OTRS", identifier_name: "TicketNr.")
    expect("#{f}").to match ("OTRS [TicketNr.]")
  end

end
