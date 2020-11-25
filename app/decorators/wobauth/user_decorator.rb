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
  end
end
