class CreateTimeAccountings < ActiveRecord::Migration[6.0]
  def change
    create_table :time_accountings do |t|
      t.belongs_to :task
      t.belongs_to :user
      t.string :description, default: ""
      t.date :date
      t.integer :duration

      t.timestamps
    end
    add_index :time_accountings, :date
  end
end
