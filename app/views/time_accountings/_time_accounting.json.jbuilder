json.extract! time_accounting, :id, :task_id, :user_id, :description, :date, :duration, :created_at, :updated_at
json.url time_accounting_url(time_accounting, format: :json)
