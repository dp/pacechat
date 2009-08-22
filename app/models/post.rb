class Post < ActiveRecord::Base
  belongs_to :chat
  belongs_to :poster
end
