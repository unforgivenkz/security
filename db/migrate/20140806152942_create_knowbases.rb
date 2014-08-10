class CreateKnowbases < ActiveRecord::Migration
  def change
    create_table :knowbases do |t|
      t.string :name
      t.string :keyword
      t.string :avatar

      t.timestamps
    end
    add_index :knowbases, :keyword
  end
end
