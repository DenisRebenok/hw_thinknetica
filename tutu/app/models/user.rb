class User < ActiveRecord::Base
  validates :name, presence: true

  has_many :tickets
  # has_many :trains, through: :tickets
end
