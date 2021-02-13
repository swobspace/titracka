class AddDayTypeToWorkday < ActiveRecord::Migration[6.0]
  def change
    add_reference :workdays, :day_type
  end
end
