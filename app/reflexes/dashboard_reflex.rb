# frozen_string_literal: true

class DashboardReflex < ApplicationReflex
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

  def cardboard
    if element.dataset[:org_unit_id].present?
       @element = OrgUnit.find(element.dataset[:org_unit_id])
    else
       @element = List.find(element.dataset[:list_id])
    end
    @columns = State.not_archived
    @tasks_per_column = @element.tasks.group_by(&:state_id)
  end

end