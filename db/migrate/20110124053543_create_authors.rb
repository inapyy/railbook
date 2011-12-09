class CreateAuthors < ActiveRecord::Migration
  def self.up
    create_table :authors do |t|
      t.references :user
      t.string :name
      t.date :birth
      t.text :address
      t.string :ctype
      t.binary :photo

      t.timestamps
    end
  end

  def self.down
    drop_table :authors
  end
end
