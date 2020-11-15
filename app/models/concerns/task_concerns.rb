module TaskConcerns
  extend ActiveSupport::Concern

  included do
    scope :not_archived, -> { joins(:state).where(states: {state: State::NOT_ARCHIVED}) }
  end

end
