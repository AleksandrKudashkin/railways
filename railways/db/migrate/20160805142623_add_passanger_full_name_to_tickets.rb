class AddPassangerFullNameToTickets < ActiveRecord::Migration
  def change
    change_table :tickets do |t|
      t.string :passenger_full_name
    end
  end
end
