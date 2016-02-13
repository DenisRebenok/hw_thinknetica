class Train < ActiveRecord::Base
  belongs_to :current_station, class_name: 'RailwayStation', foreign_key: :current_station_id
  belongs_to :route
  has_many :tickets
  # has_many :users, through: :tickets

  validates :number, presence: true#, format: {with: /^[а-яa-z\d]{3}-?[а-яa-z\d]{2}$/i, uniqueness: true}
end
