# frozen_string_literal: true

class ApplicationReflex < StimulusReflex::Reflex
  delegate :current_user, to: :connection

  def current_ability
    @current_ability ||= Ability.new(current_user)
  end
end
