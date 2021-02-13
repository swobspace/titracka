class CreateDayTypes < ActiveRecord::Migration[6.0]
  def change
    create_table :day_types do |t|
      t.string :abbrev, default: "", null: false
      t.string :description, default: ""

      t.timestamps
    end
    add_index :day_types, :abbrev
  end
end
