class AddIndexToPosts < ActiveRecord::Migration
  def self.up
    add_index :posts, [:chat_id, :created_at], :name=>'by_chat'
  end

  def self.down
    remove_index :posts, :name=>'by_chat'
  end
end
