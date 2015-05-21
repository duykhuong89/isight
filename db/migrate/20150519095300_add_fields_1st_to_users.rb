class AddFields1stToUsers < ActiveRecord::Migration
  def change
    add_column :users, :dob, :datetime
    add_column :users, :phoneno, :string
  end
end
