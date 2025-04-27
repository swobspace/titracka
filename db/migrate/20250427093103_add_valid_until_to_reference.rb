class AddValidUntilToReference < ActiveRecord::Migration[7.2]
  def change
    add_column :references, :valid_until, :date
  end
end
