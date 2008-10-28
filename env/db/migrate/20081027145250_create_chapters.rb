class CreateChapters < ActiveRecord::Migration
  def self.up
    create_table :chapters do |t|
      t.string :title
      t.string :src
      t.integer :time

      t.timestamps
    end
  end

  def self.down
    drop_table :chapters
  end
end
