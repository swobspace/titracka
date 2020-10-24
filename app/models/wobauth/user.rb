require_dependency 'wobauth/concerns/models/user_concerns'
class Wobauth::User < ActiveRecord::Base
  has_many :tasks, dependent: :restrict_with_error
  has_many :lists, dependent: :restrict_with_error
  has_many :time_accountings, dependent: :restrict_with_error
  has_many :responsibilities, dependent: :restrict_with_error
  has_many :workdays, dependent: :restrict_with_error
  # dependencies within wobauth models
  include UserConcerns

  # devise *#{@app_name}.devise_modules 
  # or ... basic usage:
  devise *Titracka.devise_modules

  validates :password, confirmation: true


  scope :active, -> { all }
end

