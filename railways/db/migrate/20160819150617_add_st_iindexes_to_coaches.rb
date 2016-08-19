class AddStIindexesToCoaches < ActiveRecord::Migration
  def change
    add_index :coaches, [:id, :type]
  end
end
