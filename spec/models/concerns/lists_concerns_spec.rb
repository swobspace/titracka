require 'rails_helper'

describe ListConcerns do
  let!(:list1) { FactoryBot.create(:list, valid_until: '2020-01-01') }
  let!(:list2) { FactoryBot.create(:list, valid_until: '2999-11-11') }
  let!(:list3) { FactoryBot.create(:list, valid_until: nil) }

  describe "#active" do
    it "selects active lists" do
      expect(List.active).to contain_exactly(list2, list3)
    end
  end
end
