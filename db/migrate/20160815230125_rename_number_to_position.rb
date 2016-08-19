class RenameNumberToPosition < ActiveRecord::Migration
  def change
    change_table :railway_stations_routes do |t|
      t.rename :number, :position
    end
  end
end
