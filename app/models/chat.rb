class Chat < ActiveRecord::Base
  def self.visible_period
    24.hours.ago
  end

  has_many :posts, 
    :order=> 'id DESC',
    :conditions => ['created_at > ?', visible_period]

  def add_post author, msg, ipaddress
    unless msg.blank?
    @poster ||= Poster.find_or_create_by_ipaddress(ipaddress)
      self.posts.create(
        :author=> get_author(author, ipaddress),
        :msg=> msg,
        :poster=> @poster)
    end
  end

  def posts_since post_id
    Post.find(
      :all,
      :order=> 'id DESC',
      :conditions=> ['chat_id= ? AND id > ? and created_at > ?',
        self.id,
        post_id,
        Chat.visible_period])
  end

  def get_author author, ipaddress
    # if no author set to anon n
    @poster ||= Poster.find_or_create_by_ipaddress(ipaddress)
    return author unless author.blank?
    "anon-#{@poster.id}"
  end

end
