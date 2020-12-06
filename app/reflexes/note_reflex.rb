# frozen_string_literal: true

class NoteReflex < ApplicationReflex
  # Add Reflex methods in this file.
  #
  # All Reflex instances expose the following properties:
  #
  #   - connection - the ActionCable connection
  #   - channel - the ActionCable channel
  #   - request - an ActionDispatch::Request proxy for the socket connection
  #   - session - the ActionDispatch::Session store for the current visitor
  #   - url - the URL of the page that triggered the reflex
  #   - element - a Hash like object that represents the HTML element that triggered the reflex
  #   - params - parameters from the element's closest form (if any)
  #
  # Example:
  #
  #   def example(argument=true)
  #     # Your logic here...
  #     # Any declared instance variables will be made available to the Rails controller and view.
  #   end
  #
  # Learn more at: https://docs.stimulusreflex.com

  def new
    Rails.logger.debug("DEBUG:: dataset = #{element.dataset}")
    @task = Task.find(element.dataset[:task_id].to_i)
    Rails.logger.debug("DEBUG:: task = #{@task}")
    @note = @task.notes.new
    morph "#noteModalForm", NotesController.render(
      partial: 'notes/modal_form',
      locals: { noteable: @task, note: @note }
    )
  end

  def edit
  end
end
