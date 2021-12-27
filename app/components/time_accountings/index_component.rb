# frozen_string_literal: true

class TimeAccountings::IndexComponent < ViewComponent::Base
  def initialize(user:)
    @user = user
  end

end
