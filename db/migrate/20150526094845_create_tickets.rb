class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.string :descr, :title
      t.timestamps
    end
  end
end
