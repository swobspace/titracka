# frozen_string_literal: true

class Workday::TimeAccountingsComponent < ViewComponent::Base
  def initialize(workday:, user:)
    @workday = workday
  end

end
