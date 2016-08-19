class CreateWagons < ActiveRecord::Migration
  def change
    create_table :wagons do |t|
      t.string :wagon_type
      t.integer :upper_places
      t.integer :lower_places
      t.belongs_to :train, index: true
      t.timestamps null: false
    end
  end
end
