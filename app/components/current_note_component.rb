# frozen_string_literal: true

class CurrentNoteComponent < ViewComponent::Base
  def initialize(notable:)
    @notable = notable
  end

  def note
    if notable.respond_to? :current_note
      notable.current_note
    else
      nil
    end
  end

  def render?
    note.present?
  end

private
  attr_reader :notable
end
