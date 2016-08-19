class AddIndexToTickets < ActiveRecord::Migration
  def change
    change_table :tickets do |t|
      t.index :first_station_id
      t.index :last_station_id
    end
  end
end
