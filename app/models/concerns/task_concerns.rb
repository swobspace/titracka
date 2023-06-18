module TaskConcerns
  extend ActiveSupport::Concern

  included do
    scope :visible, -> { joins(:state).where(states: {state: State::VISIBLE}) }
  end

end
