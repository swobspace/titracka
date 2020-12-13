require 'rails_helper'

RSpec.describe Task, type: :model do
  it { is_expected.to belong_to(:responsible).optional }
  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:org_unit).optional }
  it { is_expected.to belong_to(:list).optional }
  it { is_expected.to have_many(:time_accountings).dependent(:restrict_with_error) }
  it { is_expected.to have_many(:notes).dependent(:delete_all) }
  it { is_expected.to have_many(:cross_references).dependent(:delete_all) }
  it { is_expected.to have_rich_text(:description) }
  it { is_expected.to validate_presence_of(:subject) }
  it { is_expected.to validate_presence_of(:user_id) }
  it { is_expected.to validate_presence_of(:state_id) }
  it { is_expected.to validate_inclusion_of(:priority).in_array(Task::PRIORITIES) }
  it { is_expected.to accept_nested_attributes_for(:cross_references).allow_destroy(true) }

  it "should get plain factory working" do
    f = FactoryBot.create(:task)
    g = FactoryBot.create(:task)
    expect(f).to be_valid
    expect(g).to be_valid
  end

  it "to_s returns value" do
    f = FactoryBot.create(:task, subject: "Some Task")
    expect("#{f}").to match ("Some Task")
  end

  describe "on save" do
    let(:ou1) { FactoryBot.create(:org_unit, name: "OU1") }
    let(:ou2) { FactoryBot.create(:org_unit, name: "OU2") }
    let(:list) { FactoryBot.create(:list, org_unit: ou1) }
    it "task gets ou from list" do
      task = FactoryBot.create(:task, org_unit: ou2)
      task.update(list: list)
      task.reload
      expect(task.org_unit.name).to eq(ou1.name)
    end
  end
end
