class AddIndexToChats < ActiveRecord::Migration
  def self.up
    add_index :chats, :url
  end

  def self.down
    remove_index :chats, :url
  end
end
