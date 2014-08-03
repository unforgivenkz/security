class CreateDepartments < ActiveRecord::Migration
  def change
    create_table :departments do |t|
      t.string :name1
      t.string :name2
      t.string :name3
      t.string :tel
      t.string :post
      t.integer :dep

      t.timestamps
    end
  end
end
