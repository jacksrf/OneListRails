class List < ActiveRecord::Base
  has_many :items
  accepts_nested_attributes_for :items
  belongs_to :user
end
