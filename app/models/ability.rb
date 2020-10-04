# frozen_string_literal: true
require_relative '../../lib/wobauth/admin_ability'

class Ability
  include CanCan::Ability

  # just for development
  def initialize(user)
    if user or ( Rails.env != 'production' )
      can :manage, :all
    else
      can :read, :all
    end
  end

end
