class AddPositionToOrgUnit < ActiveRecord::Migration[6.0]
  def change
    add_column :org_units, :position, :integer, default: 0
  end
end
