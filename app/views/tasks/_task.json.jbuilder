json.extract! task, :id, :subject, :start, :deadline, :resubmission, :priority, :responsible_id, :org_unit_id, :state_id, :list_id, :private, :created_at, :updated_at
json.url task_url(task, format: :json)
