class ReduceReferenceUrl < ActiveRecord::Migration[7.2]
  def up
    add_column :references, :url, :string
    execute <<-SQL
      UPDATE "references" r
      SET 
        url = u.url
      FROM reference_urls u
      WHERE r.id = u.reference_id
    SQL
    drop_table :reference_urls
  end

  def down
    create_table :reference_urls do |t|
      t.belongs_to :reference, null: false
      t.string :name, default: ""
      t.string :url, default: ""

      t.timestamps
    end

    Reference.all.each do |r|
      unless r.url.blank?
        r.reference_urls.create!(name: r.name, url: r.url)
      end
    end

    remove_column :references, :url
  end
end
