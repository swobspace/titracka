# frozen_string_literal: true

class TimeAccountings::IndexComponent < ViewComponent::Base
  delegate :show_link, :edit_link, :delete_link, to: :helpers
  def initialize(time_accountable:)
    @time_accountable = time_accountable
    @time_accountings = time_accountable.time_accountings
  end

end
