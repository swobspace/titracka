class CreateStates < ActiveRecord::Migration[6.0]
  def change
    create_table :states do |t|
      t.string :name, default: '', null: false
      t.string :state, default: ''

      t.timestamps
    end
    add_index :states, :state, unique: true
  end
end
