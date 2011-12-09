class CreateFunComments < ActiveRecord::Migration
  def self.up
    create_table :fun_comments do |t|
      t.integer :author_no
      t.string :name
      t.text :body
      t.boolean :deleted

      t.timestamps
    end
  end

  def self.down
    drop_table :fun_comments
  end
end
