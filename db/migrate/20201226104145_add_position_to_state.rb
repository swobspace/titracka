class AddPositionToState < ActiveRecord::Migration[6.0]
  def change
    add_column :states, :position, :integer, default: 0
  end
end
