class User < ActiveRecord::Base
  has_many :lists
  has_secure_password
  # validates :first_name, presence: true
  # validates :last_name, presence: true
  # validates :address, presence: true
  # validates :city, presence: true
  # validates :state, presence: true
  # validates :zip, presence: true
  # validates :email, presence: true
  # validates :phone, presence: true
end
