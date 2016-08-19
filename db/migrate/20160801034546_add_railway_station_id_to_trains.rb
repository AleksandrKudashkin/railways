class AddRailwayStationIdToTrains < ActiveRecord::Migration
  def change
    change_table :trains do |t|
      t.belongs_to :railway_station, index: true
    end
  end
end
