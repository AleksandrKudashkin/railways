class AddNumberOfStationToRsr < ActiveRecord::Migration
  def change
    change_table :railway_stations_routes do |t|
      t.integer :number
    end
  end
end
