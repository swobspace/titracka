class CreateTasks < ActiveRecord::Migration[6.0]
  def change
    create_table :tasks do |t|
      t.string :subject
      t.date :start
      t.date :deadline
      t.date :resubmission
      t.string :priority
      t.belongs_to :responsible
      t.belongs_to :org_unit
      t.belongs_to :state, null: false
      t.belongs_to :list
      t.boolean :private

      t.timestamps
    end
    add_index :tasks, :start
    add_index :tasks, :deadline
    add_index :tasks, :resubmission
    add_index :tasks, :priority
  end
end
