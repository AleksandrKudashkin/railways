class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.belongs_to :train, index: true
      t.integer :first_station_id
      t.integer :last_station_id

      t.timestamps null: false
    end
  end
end
