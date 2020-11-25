module TasksHelper
  def raci(task)
    output = ""
    if task.responsible.present?
      output += %Q[<span class="responsible">R: #{task.responsible.decorate.shortname}</span>]
    end
    output.html_safe
  end
end
