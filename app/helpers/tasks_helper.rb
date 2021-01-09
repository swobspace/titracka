module TasksHelper
  def raci(task, options = {})
    options = options.symbolize_keys
    fields = options.fetch(:fields) { "RA" }
    output = []
    if task.responsible.present? and fields.include?("R")
      output << %Q[<span class="responsible">R: #{task.responsible.decorate.shortname}</span>]
    end
    if task.user.present? and fields.include?("A")
      output << %Q[<span class="owner">A: #{task.user.decorate.shortname}</span>]
    end
    output.join("<br />").html_safe
  end

  def timeline(task, options = {})
    options = options.symbolize_keys
    full = options.fetch(:full) { false }
    output = ""
    phase = task.decorate.phase
    if task.start.present? and full
      output += %Q[<span class="start #{phase} mr-2"><i class="fas fa-calendar-alt"></i> #{task.start}</span>]
    end
    if task.deadline.present?
      output += %Q[<span class="deadline #{phase}"><i class="fas fa-flag-checkered"></i> #{task.deadline}</span>]
    end
    output.html_safe
  end

  def mailaddresses_for_select(task, current_user = nil)
    addresses = [""]
    addresses << Titracka.mail_to
    addresses << email_for_select(current_user)
    addresses << email_for_select(task.user)
    addresses << email_for_select(task.responsible)
    addresses.uniq.compact
  end

private
  def email_for_select(user)
    if user.blank? || user.email.blank?
      nil
    else
      user.email
    end
  end
end
