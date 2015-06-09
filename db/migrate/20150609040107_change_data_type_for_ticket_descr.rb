class ChangeDataTypeForTicketDescr < ActiveRecord::Migration
  def self.up
    change_table :tickets do |t|
      t.change :descr, :text
    end
  end
  def self.down
    change_table :tickets do |t|
      t.change :descr, :string
    end
  end
end
