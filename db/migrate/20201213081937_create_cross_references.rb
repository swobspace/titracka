class CreateCrossReferences < ActiveRecord::Migration[6.0]
  def change
    create_table :cross_references do |t|
      t.belongs_to :task, null: false
      t.belongs_to :reference, null: false
      t.string :identifier, default: ""

      t.timestamps
    end
  end
end
