class AddStartEndStationsIdsToTickets < ActiveRecord::Migration
  def change
    # add_column :tickets, :start_station_id, :integer
    add_belongs_to :tickets, :start_station
    add_belongs_to :tickets, :end_station
  end
end
