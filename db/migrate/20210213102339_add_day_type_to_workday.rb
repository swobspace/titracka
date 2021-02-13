class AddDayTypeToWorkday < ActiveRecord::Migration[6.0]
  def change
    add_reference :workdays, :daytype, null: false, foreign_key: false
  end
end
