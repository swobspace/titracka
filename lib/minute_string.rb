module MinuteString
  # 180 -> 3:00
  def MinuteString.min2hour(minutes = 0)
    minutes ||= 0
    hours = minutes / 60
    minutes = minutes % 60
    sprintf "%02d:%02d", hours, minutes
  end

  # 3:00 -> 180
  def MinuteString.hour2min(text = "0:00")
    full, outer, hour, min = text.match(/((\d{1,2}):|)(\d{1,2})/).to_a.map(&:to_i)
    hour ||= 0
    min  ||= 0
    minutes = hour * 60 + min
  end
end
