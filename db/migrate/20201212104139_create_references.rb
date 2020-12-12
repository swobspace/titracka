class CreateReferences < ActiveRecord::Migration[6.0]
  def change
    create_table :references do |t|
      t.string :name, default: ""
      t.string :identifier_name, default: ""

      t.timestamps
    end
  end
end
