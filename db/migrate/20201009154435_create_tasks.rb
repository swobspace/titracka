class CreateTasks < ActiveRecord::Migration[6.0]
  def change
    create_table :tasks do |t|
      t.string :subject
      t.date :start
      t.date :deadline
      t.date :resubmission
      t.string :priority
      t.belongs_to :responsible, true: false, foreign_key: true
      t.belongs_to :org_unit, null: true, foreign_key: true
      t.belongs_to :state, null: false, foreign_key: true
      t.belongs_to :list, null: true, foreign_key: true
      t.boolean :private

      t.timestamps
    end
    add_index :tasks, :start
    add_index :tasks, :deadline
    add_index :tasks, :resubmission
    add_index :tasks, :priority
  end
end
