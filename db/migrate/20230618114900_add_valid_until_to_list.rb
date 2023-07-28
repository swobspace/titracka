class AddValidUntilToList < ActiveRecord::Migration[7.0]
  def change
    add_column :lists, :valid_until, :date
  end
end
