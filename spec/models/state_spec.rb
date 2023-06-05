require 'rails_helper'

RSpec.describe State, type: :model do
  fixtures :states
  it { is_expected.to have_many(:tasks).dependent(:restrict_with_error) }
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_inclusion_of(:state).in_array(State::STATES) }


  it "should get plain factory working" do
    f = FactoryBot.create(:state)
    g = FactoryBot.create(:state)
    expect(f).to validate_uniqueness_of(:name).case_insensitive
    expect(f).to be_valid
    expect(g).to be_valid
    expect(f.position).to eq(State.count - 1)
    expect(g.position).to eq(State.count)
  end

  it "to_s returns value" do
    f = FactoryBot.create(:state, name: "Topicstore", state: "pre")
    expect("#{f}").to match ("Topicstore")
  end

  describe "scopes" do
    let!(:s_open) { states(:open) }
    let!(:s_pending) { states(:pending) }
    let!(:s_pre) { states(:pre) }
    let!(:s_done) { states(:done) }
    let!(:s_archive) { states(:archive) }
    let!(:s_atwork) { states(:atwork) }

    describe "#not_archived" do
      it { expect(State.not_archived).to contain_exactly(s_open, s_atwork, s_pending, s_pre, s_done) }
    end
    describe "#open" do
      it { expect(State.open).to contain_exactly(s_open, s_atwork, s_pending) }
    end
    describe "#active" do
      it { expect(State.active).to contain_exactly(s_pre, s_open, s_atwork, s_pending) }
    end

  end


end
