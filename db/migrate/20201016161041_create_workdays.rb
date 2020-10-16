class CreateWorkdays < ActiveRecord::Migration[6.0]
  def change
    create_table :workdays do |t|
      t.belongs_to :user, null: false
      t.date :date
      t.time :work_start
      t.integer :pause, default: 0

      t.timestamps
    end
    add_index :workdays, :date
  end
end
