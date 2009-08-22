class CreatePosts < ActiveRecord::Migration
  def self.up
    create_table :posts do |t|
      t.integer :poster_id
      t.integer :chat_id
      t.string :author
      t.text :msg

      t.timestamps
    end
  end

  def self.down
    drop_table :posts
  end
end
