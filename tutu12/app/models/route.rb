class Route < ActiveRecord::Base
  validates :title, presence: true

  has_many :railway_stations_routes
  has_many :railway_stations, through: :railway_stations_routes #Модель Маршрут имеет множество станций.

  has_many :trains # на одном маршруте может быть несколько поездов
end
