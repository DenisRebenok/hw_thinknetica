class User < ActiveRecord::Base
  has_many :tickets
  # has_many :trains, through: :tickets
  
  validates :name, presence: true
end
