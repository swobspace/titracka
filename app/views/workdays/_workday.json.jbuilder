date_format = "%Y-%m-%d"

title = []

if workday.day_type.present?
  title << workday.day_type&.abbrev
end

if workday.decorate.duration > 0
  title << hourmin(workday.decorate.duration)
end

title = title.compact.join(" - ")

json.extract! workday, :id
# json.title [workday.day_type, workday.decorate.duration, workday.comment].join("\n")
json.title title
json.url workday_url(workday, format: :html)
json.show_url workday_url(workday, format: :html)
json.start workday.date
# json.end workday.end_time.strftime(date_format)
# json.allDay workday.all_day

if workday.day_type.blank?
  if workday.decorate.duration == 0
    json.backgroundColor '#FFFFFF'
  end
else
  json.backgroundColor '#FFB700'
  json.textColor '#111'
end

json.classNames ['text-center']
