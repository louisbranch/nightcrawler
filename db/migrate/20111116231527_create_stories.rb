class CreateStories < ActiveRecord::Migration
  def change
    create_table :stories do |t|
      t.integer :source_id
      t.integer :original_id
      t.string :title
      t.integer :author_id
      t.text :content
      t.integer :likes, :default => 0
      t.string :slug, :unique => true

      t.timestamps
    end
  end
end
