require 'rails_helper'

RSpec.describe CrossReferenceDecorator do
  let(:reference) { FactoryBot.create(:reference, 
    name: "DontDoIT", 
    url: "https://example.com/dontdoit/###IDENTIFIER###"
  )}


  describe "#with_links" do
    let(:decorated) { Capybara.string(cross_reference.decorate.with_links) }
    let(:cross_reference) { FactoryBot.create(:cross_reference,
      reference_id: reference.id,
      identifier: "776508"
    )}
    it { expect(cross_reference.decorate.with_links).to match("DontDoIT#776508") }
    it "get linked strings" do
      expect(decorated.all('a').map{|a| a['href']}).to contain_exactly(
        "https://example.com/dontdoit/776508",
      )
    end
  end
end
