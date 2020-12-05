require 'rails_helper'

RSpec.describe Note, type: :model do
  let(:task) { FactoryBot.create(:task, subject: "Some Task" ) }
  let(:user) { FactoryBot.create(:user, givenname: "Max", sn: "Mustermann") }
  it { is_expected.to belong_to(:task) }
  it { is_expected.to belong_to(:user) }
  it { is_expected.to validate_presence_of(:description) }
  it { is_expected.to validate_presence_of(:date) }
  it { is_expected.to validate_presence_of(:user_id) }
  it { is_expected.to validate_presence_of(:task_id) }


  it "should get plain factory working" do
    f = FactoryBot.create(:note)
    g = FactoryBot.create(:note)
    expect(f).to be_valid
    expect(g).to be_valid
  end

  it "to_s returns value" do
    f = FactoryBot.create(:note, description: "Some Addons", date: "2020-01-10", task: task)
    expect("#{f}").to match ("Some Addons")
  end
end
