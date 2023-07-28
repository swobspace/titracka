require 'rails_helper'

describe OrgUnitConcerns do
  let!(:ou1)    { FactoryBot.create(:org_unit, name: "ou1") }
  let!(:ou2)    { FactoryBot.create(:org_unit, name: "ou2") }
  let!(:ou3)    { FactoryBot.create(:org_unit, name: "ou3") }
  let!(:ou11)   { FactoryBot.create(:org_unit, parent: ou1, name: "ou11") }
  let!(:ou12)   { FactoryBot.create(:org_unit, parent: ou1, name: "ou12") }
  let!(:ou13)   { FactoryBot.create(:org_unit, parent: ou1, name: "ou13") }
  let!(:ou121)  { FactoryBot.create(:org_unit, parent: ou12, name: "ou121") }
  let!(:ou122)  { FactoryBot.create(:org_unit, parent: ou12, name: "ou122") }
  let!(:ou123)  { FactoryBot.create(:org_unit, parent: ou12, name: "ou123") }
  let!(:ou124)  { FactoryBot.create(:org_unit, parent: ou12, name: "ou124", 
                                    valid_until: '2020-01-01') }
  let!(:ou131)  { FactoryBot.create(:org_unit, parent: ou13, name: "ou131",
                                    valid_until: '2999-12-13') }
  let(:arrow)   { " #{[8594].pack('U*')} " }

  describe "#arrange_as_array" do
    it "orders children with same parent" do
      ou3.update(position: 1)
      ou11.update(position: 3)
      ou123.update(position: 1)
      expect(OrgUnit.active.arrange_as_array(order: 'position').pluck(:id).to_a).to eq(
        [ou3, ou1, ou12, ou123, ou121, ou122, ou13, ou131, ou11, ou2].map(&:id)
      )
    end
  end

  describe "#active" do
    it "selects active units" do
      expect(OrgUnit.active).to contain_exactly(
        ou3, ou1, ou12, ou123, ou121, ou122, ou13, ou131, ou11, ou2
      )
    end
  end
end
