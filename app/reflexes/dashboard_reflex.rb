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
    ability = Ability.new(current_user)
    if element.dataset[:element_type] == 'org_unit'
       @element = OrgUnit.accessible_by(ability).where(id: element.dataset[:element_id]).first
    elsif element.dataset[:element_type] == 'list'
       @element = List.accessible_by(ability).where(id: element.dataset[:element_id]).first
    end
    return if @element.nil?
    @columns = State.not_archived
    @tasks_per_column = @element.tasks.accessible_by(ability).group_by(&:state_id)
    morph "#dashboardContent", HomeController.render(
      partial: 'tasks/cards', 
      locals: { columns: @columns, tasks_per_column: @tasks_per_column }
    )
  end

end
