# frozen_string_literal: true
require_relative '../../lib/wobauth/admin_ability'

class Ability
  include CanCan::Ability

  # just for development
  def initialize(user)
    if user
      can :manage, :all
    end
  end

end
