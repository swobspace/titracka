class AddCommentToWorkday < ActiveRecord::Migration[6.0]
  def change
    add_column :workdays, :comment, :string, default: ""
  end
end
