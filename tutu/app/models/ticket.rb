class Ticket < ActiveRecord::Base
  belongs_to :train
  belongs_to :start_station, class_name: 'RailwayStation', foreign_key: :start_station_id
  belongs_to :end_station, class_name: 'RailwayStation', foreign_key: :end_station_id
  belongs_to :user

  validates :train, presence: true
  validates :start_station, presence: true
  validates :end_station, presence: true
  validates :user, presence: true
end
