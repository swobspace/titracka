class CreateReferenceUrls < ActiveRecord::Migration[6.0]
  def change
    create_table :reference_urls do |t|
      t.belongs_to :reference, null: false
      t.string :name, default: ""
      t.string :url, default: ""

      t.timestamps
    end
  end
end
