class AddStItoCoaches < ActiveRecord::Migration
  def change
    change_table :coaches do |t|
      t.rename :wagon_type, :type
      t.rename :upper_places, :top_seats
      t.rename :lower_places, :bottom_seats
      t.integer :side_top_seats
      t.integer :side_bottom_seats
      t.integer :simple_seats
    end
  end
end
