date_format = "%Y-%m-%d"
json.extract! workday, :id
# json.title [workday.day_type, workday.decorate.duration, workday.comment].join("\n")
json.title hourmin(workday.decorate.duration)
json.url workday_url(workday, format: :html)
json.show_url workday_url(workday, format: :html)
json.start workday.date
# json.end workday.end_time.strftime(date_format)
# json.allDay workday.all_day
