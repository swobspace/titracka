class CreateLists < ActiveRecord::Migration[6.0]
  def change
    create_table :lists do |t|
      t.belongs_to :org_unit, null: true, foreign_key: true
      t.string :name, default: ""

      t.timestamps
    end
    add_index :lists, :name
  end
end
