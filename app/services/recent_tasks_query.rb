class RecentTasksQuery
  attr_reader :tasks

  def initialize(options = {})
    options.symbolize_keys!
    @user_id = options.fetch(:user_id)
    @period  = 28
    options.each do |key,value|
      case key
      when :user_id
      # noting
      when :period
        @period  = value.to_i
      else
        raise ArgumentError, "unknown search option #{key}"
      end
    end
    @tasks   ||= fetch_tasks
  end

private
  attr_reader :user_id, :period

  def fetch_tasks
    time_accountings = TimeAccounting
                       .where(user_id: user_id)
                       .where("date > ?", period.days.before(Date.today))
    weighted = Hash.new
    time_accountings.each do |ta|
      weighted[ta.task_id] = 0 if weighted[ta.task_id].nil?
      weighted[ta.task_id] += (period - (Date.today - ta.date).to_i)
    end
    weighted = weighted.sort_by{|k,v| v}.reverse.to_h
    tasks = Task.find(weighted.keys)
  end
end
