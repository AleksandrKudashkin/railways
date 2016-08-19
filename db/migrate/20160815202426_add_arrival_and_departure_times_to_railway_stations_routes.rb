class AddArrivalAndDepartureTimesToRailwayStationsRoutes < ActiveRecord::Migration
  def change
    change_table :railway_stations_routes do |t|
      t.time :arrival_time
      t.time :departure_time
    end
  end
end
