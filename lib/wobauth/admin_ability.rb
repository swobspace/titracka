module Wobauth
  class AdminAbility
    include CanCan::Ability

    WOBAUTH_CLASSES = [ Wobauth::User, Wobauth::Group, Wobauth::Membership,
                        Wobauth::Role, Wobauth::Authority ]

    def orga_admin(authorized_for)
      can :navigate, [:configuration, :dashboard]
      can [:navigate, :read], WOBAUTH_CLASSES
    end
  end
end
