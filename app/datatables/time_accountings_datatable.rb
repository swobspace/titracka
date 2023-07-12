class TimeAccountingsDatatable < ApplicationDatatable
  delegate :task_path, to: :@view

  def initialize(relation, view)
    @view = view
    @relation = relation
  end

  private
  attr_reader :relation

  def data
    time_accountings.map do |time_accounting|
      links = []
      links << show_link(time_accounting)
      links << edit_link(time_accounting, "data-turbo-frame": "modal")
      links << delete_link(time_accounting)
      {
        "0" => time_accounting.date,
        "1" => time_accounting.duration,
        "2" => time_accounting.formatted_duration,
        "3" => link_to(time_accounting.task.subject, task_path(time_accounting.task),
                          class: 'primary-link'),
        "4" => time_accounting.description,
        "5" => time_accounting.user.to_s,

        "6" => links.join(' '),
        "DT_RowId" => dom_id(time_accounting),
        "DT_RowClass" => dom_class(time_accounting)
      }
    end
  end

  def count
    @relation.count
  end

  def total_entries
    if params['length'] == "-1"
      TimeAccounting.count
    else
      time_accountings_query.count
    end
  end

  def time_accountings
    @time_accountings ||= fetch_time_accountings
  end

  def time_accountings_query
    time_accountings = relation.order("#{sort_column} #{sort_direction}")
    time_accountings = TimeAccountingQuery.new(time_accountings.joins(:task), 
                                               search_params(params, search_columns)).all
  end

  def fetch_time_accountings
    if params['length'] == "-1"
      time_accountings = time_accountings_query
    else
      @pagy, time_accountings = pagy(time_accountings_query, page: page, items: per_page)
    end
    time_accountings
  end

  def columns
    %w[time_accountings.date time_accountings.duration 
       time_accountings.duration tasks.subject 
       time_accountings.description time_accountings.user_id]
  end

  def search_columns
    %w[date duration formatted_duration task description user]
  end
end
