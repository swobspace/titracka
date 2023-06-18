class AddValidUntilToOrgUnit < ActiveRecord::Migration[7.0]
  def change
    add_column :org_units, :valid_until, :date
  end
end
