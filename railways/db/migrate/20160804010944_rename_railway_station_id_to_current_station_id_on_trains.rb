class RenameRailwayStationIdToCurrentStationIdOnTrains < ActiveRecord::Migration
  def change
    change_table :trains do |t|
      t.rename :railway_station_id, :current_station_id
    end
  end
end
