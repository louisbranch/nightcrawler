class CreateSources < ActiveRecord::Migration
  def change
    create_table :sources do |t|
      t.integer :type_id, :default => 1
      t.string :title
      t.string :url
      t.string :parse_url
      t.integer :crawl_rate, :default => 5
      t.boolean :active, :default => false
      t.string :last_created_item, :default => '0'
      t.string :last_parsed_item, :default => '0'

      t.timestamps
    end
  end
end
