# frozen_string_literal: true

class TaskReflex < ApplicationReflex
  before_reflex :get_ability
  before_reflex :set_associations

  def show
    @task = Task.find(element.dataset[:id].to_i)
    morph "#showTaskModalTable", TasksController.render(
      partial: 'tasks/show_task', locals: { task: @task }
    )
    morph "#showTaskNotesCollection", NotesController.render(
      partial: 'notes/note', collection: @task.notes, 
      layout: '../shared/list_group_item_layout'
    )
  end

  def new
    state_id = element.dataset[:column_id].to_i
    Rails.logger.debug("DEBUG:: #{element.dataset.inspect}")
    filter = JSON.parse(element.dataset[:filter])
    @task = Task.new({state_id: state_id}.merge(filter))
    morph "#taskModalForm", TasksController.render(
      partial: 'tasks/modal_form',
      locals: { task: @task, users: @users, org_units: @org_units, lists: @lists }
    )
  end

  def edit
    @task = Task.find(element.dataset[:id].to_i)
    morph "#taskModalForm", TasksController.render(
      partial: 'tasks/modal_form',
      locals: { task: @task, users: @users, org_units: @org_units, lists: @lists }
    )
  end


  private
    def get_ability
      @ability ||= Ability.new(current_user)
    end

    def set_associations
      @users ||= Wobauth::User.active.order("sn, givenname")
      @org_units ||= OrgUnit.where(id: @ability.rights.manager.org_units)
      @lists ||= List.accessible_by(@ability, :read).order(:name)
    end
end
