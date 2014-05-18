class CreateDepartments < ActiveRecord::Migration
  def change
    create_table :departments do |t|
      t.string :surname
      t.string :name1
      t.string :name2
      t.string :post
      t.integer :tel
      t.string :group

      t.timestamps
    end
  end
end
