require 'rails_helper'

RSpec.describe TaskDecorator do
  let(:ou) { FactoryBot.create(:org_unit, name: "ACME Ltd") }
  let(:plain_list) { FactoryBot.create(:list, name: "Plain List") }
  let(:ou_list) { FactoryBot.create(:list, name: "OU List", org_unit: ou) }

  let(:decorated) { decorated = task.decorate }

  describe "#name_with_list_or_org_unit" do
    describe "task with org_unit and list" do
      let(:task) { FactoryBot.create(:task, list: ou_list, subject: "MySubject") }
      it { expect(decorated.name_with_list_or_org_unit).to eq("ACME Ltd / OU List / MySubject") }
    end
    describe "task with org_unit" do
      let(:task) { FactoryBot.create(:task, org_unit: ou, subject: "MySubject") }
      it { expect(decorated.name_with_list_or_org_unit).to eq("ACME Ltd / MySubject") }
    end
    describe "task with list" do
      let(:task) { FactoryBot.create(:task, list: plain_list, subject: "MySubject") }
      it { expect(decorated.name_with_list_or_org_unit).to eq("Plain List / MySubject") }
    end
    describe "task without ou or list" do
      let(:task) { FactoryBot.create(:task, subject: "MySubject") }
      it { expect(decorated.name_with_list_or_org_unit).to eq("MySubject") }
    end
  end

end
