# frozen_string_literal: true

class TimeAccountings::IndexComponent < ViewComponent::Base
  delegate :show_link, :edit_link, :delete_link, to: :helpers
  def initialize(user:)
    @user = user
    @time_accountings = user.time_accountings
  end

end
