module TasksHelper
  def raci(task)
    output = ""
    if task.responsible.present?
      output += %Q[<span class="responsible">R: #{task.responsible.decorate.shortname}</span>]
    end
    output.html_safe
  end

  def timeline(task)
    output = ""
    phase = task.decorate.phase
    # if task.start.present?
    #   output += %Q[<span class="start #{phase} mr-2"><i class="fas fa-calendar-alt"></i> #{task.start}</span>]
    # end
    if task.deadline.present?
      output += %Q[<span class="deadline #{phase}"><i class="fas fa-flag-checkered"></i> #{task.deadline}</span>]
    end
    output.html_safe
  end
end
