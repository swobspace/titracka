class CreateOrgUnits < ActiveRecord::Migration[6.0]
  def change
    create_table :org_units do |t|
      t.string :name, default: ""
      t.string :ancestry

      t.timestamps
    end
    add_index :org_units, :name
    add_index :org_units, :ancestry
  end
end
