require 'rails_helper'

RSpec.describe TimeAccounting, type: :model do
  let(:task) { FactoryBot.create(:task, subject: "Some Task" ) }
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
    f = FactoryBot.create(:time_accounting, description: "Meeting", date: "2020-01-10", duration: 300, task: task)
    expect("#{f}").to match ("2020-01-10 /300/ Some Task : Meeting")
  end

  describe "#formatted_duration" do
    let(:ta) { FactoryBot.create(:time_accounting) }
    it { ta.update(duration: 30); expect(ta.formatted_duration).to eq("00:30") }
    it { ta.update(duration: 90); expect(ta.formatted_duration).to eq("01:30") }
    it { ta.update(duration: 300); expect(ta.formatted_duration).to eq("05:00") }
  end

  describe "#formatted_duration=()" do
    let(:ta) { FactoryBot.create(:time_accounting) }
    it { ta.update(formatted_duration: "00:34"); expect(ta.duration).to eq(34) }
    it { ta.update(formatted_duration: "0:36"); expect(ta.duration).to eq(36) }
    it { ta.update(formatted_duration: ":37"); expect(ta.duration).to eq(37) }
    it { ta.update(formatted_duration: "01:37"); expect(ta.duration).to eq(97) }
    it { ta.update(formatted_duration: "1:37"); expect(ta.duration).to eq(97) }
    it { ta.update(formatted_duration: "61"); expect(ta.duration).to eq(61) }
    it { pending ;ta.update(formatted_duration: "120"); expect(ta.duration).to eq(120) }
  end

end
