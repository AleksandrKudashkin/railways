class AddCountingNumberToCoach < ActiveRecord::Migration
  def change
    change_table :coaches do |t|
      t.integer :counting_number
    end
  end
end
