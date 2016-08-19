class AddRouteIdToTrains < ActiveRecord::Migration
  def change
    change_table :trains do |t|
      t.integer :route_id
      t.index :route_id
    end
  end
end
