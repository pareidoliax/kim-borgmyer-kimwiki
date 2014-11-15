class AddDetailsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :role, :string
    add_column :users, :premium, :timestamp
  end
end
