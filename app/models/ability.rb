# frozen_string_literal: true

class Ability
  include CanCan::Ability

  # just for development
  def initialize(user)
    if user or ( Rails.env != 'production' )
      can :access, :all
    else
      can :read, :all
    end
  end

end
