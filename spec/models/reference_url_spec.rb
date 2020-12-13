require 'rails_helper'

RSpec.describe ReferenceUrl, type: :model do
  it { is_expected.to belong_to(:reference).optional(false) }
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:url) }

  it "should get plain factory working" do
    f = FactoryBot.create(:reference_url)
    g = FactoryBot.create(:reference_url)
    expect(f).to be_valid
    expect(g).to be_valid
  end

  it "to_s returns value" do
    f = FactoryBot.create(:reference_url, name: "Web", url: "https://example.com?#bla#")
    expect("#{f}").to match ("Web [ https://example.com?#bla# ]")
  end

end
