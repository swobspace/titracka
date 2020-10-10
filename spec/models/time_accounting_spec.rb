require 'rails_helper'

RSpec.describe TimeAccounting, type: :model do
  it { is_expected.to belong_to(:task) }
  it { is_expected.to belong_to(:user) }
  it { is_expected.to validate_presence_of(:description) }
  it { is_expected.to validate_presence_of(:date) }
  it { is_expected.to validate_presence_of(:duration) }
  it { is_expected.to validate_presence_of(:user_id) }
  it { is_expected.to validate_presence_of(:task_id) }


  it "should get plain factory working" do
    f = FactoryBot.create(:time_accounting)
    g = FactoryBot.create(:time_accounting)
    expect(f).to be_valid
    expect(g).to be_valid
  end

  it "to_s returns value" do
    task = FactoryBot.create(:task, subject: "Some Task" )
    f = FactoryBot.create(:time_accounting, description: "Meeting", date: "2020-01-10", duration: 300)
    expect("#{f}").to match ("2020-01-10 /300/ Some Task : Meeting")
  end


end
