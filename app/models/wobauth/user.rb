require_dependency 'wobauth/concerns/models/user_concerns'
module Wobauth
  class User < ApplicationRecord
    has_many :tasks, dependent: :restrict_with_error
    has_many :lists, dependent: :restrict_with_error
    has_many :time_accountings, dependent: :restrict_with_error
    has_many :notes, dependent: :delete_all
    has_many :responsibilities, dependent: :restrict_with_error, class_name: 'Task', foreign_key: :responsible_id
    has_many :workdays, dependent: :restrict_with_error
    # dependencies within wobauth models
    include UserConcerns

    # devise *#{@app_name}.devise_modules 
    # or ... basic usage:
    devise *Titracka.devise_modules

    validates :password, confirmation: true

    scope :active, -> { all }

    def short_name
      if sn.blank? and givenname.blank?
        "#{username}"
      else
        "#{sn}, #{givenname}"
      end
    end
  end
end
