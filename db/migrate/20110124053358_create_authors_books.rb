class CreateAuthorsBooks < ActiveRecord::Migration
  def self.up
    create_table :authors_books, :id => false do |t|
      t.references :author
      t.references :book

    end
  end

  def self.down
    drop_table :authors_books
  end
end
