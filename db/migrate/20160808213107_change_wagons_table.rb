class ChangeWagonsTable < ActiveRecord::Migration
  def change
    rename_table :wagons, :coaches
  end
end
