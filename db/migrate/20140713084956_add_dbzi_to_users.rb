class AddDbziToUsers < ActiveRecord::Migration
  def change
    add_column :users, :dbzi, :boolean, default: false
  end
end
