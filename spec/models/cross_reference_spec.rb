require 'rails_helper'

RSpec.describe CrossReference, type: :model do
  it { is_expected.to belong_to(:reference).optional(false) }
  it { is_expected.to belong_to(:task).optional(false) }
  it { is_expected.to validate_presence_of(:identifier) }

  it "should get plain factory working" do
    f = FactoryBot.create(:cross_reference)
    g = FactoryBot.create(:cross_reference)
    expect(f).to be_valid
    expect(g).to be_valid
  end

  it "to_s returns value" do
    f = FactoryBot.create(:cross_reference, identifier: "08154711")
    expect("#{f}").to match ("08154711")
  end

end

