class AddSortingFlagToTrains < ActiveRecord::Migration
  def change
    change_table :trains do |t|
      t.boolean :sorted_from_head
    end

    change_column_default :trains, :sorted_from_head, true
  end
end
