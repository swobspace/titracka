json.extract! workday, :id, :user_id, :date, :work_start, :pause, :created_at, :updated_at
json.url workday_url(workday, format: :json)
