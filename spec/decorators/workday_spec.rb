require 'rails_helper'

RSpec.describe WorkdayDecorator do
  include_context "time_accounting variables"

  let(:decorated) { decorated = wday1.decorate }

  describe "#duration" do
    it { expect(decorated.duration).to eq(105) }
  end
end
