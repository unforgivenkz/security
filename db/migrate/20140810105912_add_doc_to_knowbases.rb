class AddDocToKnowbases < ActiveRecord::Migration
  def change
    add_column :knowbases, :doc, :string
  end
end
