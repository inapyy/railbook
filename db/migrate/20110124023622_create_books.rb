class CreateBooks < ActiveRecord::Migration
  def self.up
    create_table :books do |t|
      t.string :isbn
      t.string :title
      t.integer :price
      t.string :publish
      t.date :published
      t.boolean :cd

      t.timestamps
    end
  end

  def self.down
    drop_table :books
  end
end
