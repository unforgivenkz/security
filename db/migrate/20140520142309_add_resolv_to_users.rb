class AddResolvToUsers < ActiveRecord::Migration
  def change
    add_column :users, :resolv, :string
  end
end
