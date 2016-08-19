class AddUserIdToTickets < ActiveRecord::Migration
  def change
    change_table :tickets do |t|
      t.belongs_to :user, index: true
    end
  end
end
