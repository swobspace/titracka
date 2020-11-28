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
    @columns = State.not_archived
    @filter = { "#{element.dataset[:element_type]}_id".to_sym => element.dataset[:element_id] }
    if element.dataset[:element_type] == 'org_unit'
      @element = OrgUnit.accessible_by(ability)
                        .where(id: element.dataset[:element_id])
                        .first
      return if @element.nil?
      @url_params = "org_unit_id=#{@element.id}"
      @tasks_per_column = @element.tasks
                                  .accessible_by(ability)
                                  .group_by(&:state_id)

    elsif ['list', 'list_decorator'].include?(element.dataset[:element_type])
      @element = List.accessible_by(ability)
                     .where(id: element.dataset[:element_id])
                     .first
      return if @element.nil?
      @url_params = "list_id=#{@element.id}"
      @tasks_per_column = @element.tasks
                                  .accessible_by(ability)
                                  .group_by(&:state_id)

    elsif element.dataset[:element_type] == 'privateTasks'
      @filter = { "private" => true }
      @url_params = "private=true"
      @tasks_per_column = Task.accessible_by(ability)
                              .where(org_unit_id: nil, list_id: nil)
                              .group_by(&:state_id)
    end
    morph "#dashboardContent", HomeController.render(
      partial: 'tasks/cards', 
      locals: { 
        columns: @columns, 
        tasks_per_column: @tasks_per_column,
        filter: @filter,
        url: "#{request.path}?#{@url_params}"
      }
    )
  end

end
