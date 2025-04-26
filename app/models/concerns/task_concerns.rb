module TaskConcerns
  extend ActiveSupport::Concern

  included do
    scope :visible, -> { joins(:state).where(states: {state: State::VISIBLE}) }
  end

  def current_note
    notes.order("date desc").first
  end
end
