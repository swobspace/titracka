require 'rails_helper'

RSpec.describe WorkdayDecorator do
  include_context "time_accounting variables"

  let(:decorated) { decorated = wday1.decorate }

  describe "#duration" do
    it { expect(decorated.duration).to eq(105) }
  end

  describe "#work_start_hourmin" do
    describe "work_start = nil" do
      it { expect(decorated.work_start_hourmin).to eq("00:00") }
    end
    describe "work_start = 7:40" do
      before(:each) do
        wday1.update(work_start: "07:40")
      end
      it { expect(decorated.work_start_hourmin).to eq("07:40") }
    end
  end
end
