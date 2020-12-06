class CreateNotes < ActiveRecord::Migration[6.0]
  def change
    create_table :notes do |t|
      t.belongs_to :task, null: false
      t.belongs_to :user, null: false
      t.date :date

      t.timestamps
    end
  end
end
