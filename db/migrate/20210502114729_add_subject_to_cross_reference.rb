class AddSubjectToCrossReference < ActiveRecord::Migration[6.0]
  def change
    add_column :cross_references, :subject, :string, default: ""
  end
end
