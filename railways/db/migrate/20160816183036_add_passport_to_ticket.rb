class AddPassportToTicket < ActiveRecord::Migration
  def change
    change_table :tickets do |t|
      t.string :passport
    end
  end
end
