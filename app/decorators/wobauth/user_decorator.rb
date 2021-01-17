module Wobauth
  class UserDecorator < Draper::Decorator
    # decorates Wobauth::User

    def shortname
      if object.sn.blank? and object.givenname.blank?
        "#{object.username}" 
      else
        "#{object.sn}, #{object.givenname}"
      end
    end

    def working_time(options = {})
      options = options.symbolize_keys
      if day = options.fetch(:day, false)
        object.time_accountings.where(date: day).sum(:duration)
      elsif day = options.fetch(:week, false)
        if day.kind_of? String
          day = Date.parse(day)
        end
        week = (day.beginning_of_week .. day.end_of_week)
        object.time_accountings.where(date: week).sum(:duration)
      end
    end
  end
end
