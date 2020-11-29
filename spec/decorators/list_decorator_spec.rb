require 'rails_helper'

RSpec.describe ListDecorator do

  let(:list) { FactoryBot.create(:list, position: 5) } 
  let(:decorated) { decorated = list.decorate }

  context "without org_unit" do
    describe "#depth" do
      it { expect(decorated.depth).to eq (0) }
    end
    describe "#children" do
      it { expect(decorated.children).to contain_exactly() }
    end
    describe "#descendant_ids" do
      it { expect(decorated.children).to contain_exactly() }
    end
    describe "#position" do
      it { expect(decorated.position).to eq (1005) }
    end
  end

  context "with org_unit" do
    let(:ou) { FactoryBot.create(:org_unit, position: 3) }
    let(:list) { FactoryBot.create(:list, org_unit: ou, position: 5) }
    describe "#depth" do
      it { expect(decorated.depth).to eq (1) }
    end
    describe "#children" do
      it { expect(decorated.children).to contain_exactly() }
    end
    describe "#descendant_ids" do
      it { expect(decorated.children).to contain_exactly() }
    end
    describe "#position" do
      it { expect(decorated.position).to eq (5) }
    end
  end
end
