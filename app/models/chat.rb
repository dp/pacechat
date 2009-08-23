class Chat < ActiveRecord::Base
  has_many :posts, :order=> 'id DESC'

  def add_post author, msg, ipaddress
    unless msg.blank?
      self.posts.create(
        :author=> get_author(author, ipaddress),
        :msg=> msg,
        :poster=> @poster)
    end
  end

  def get_author author, ipaddress
    # if no author set to anon n
    return author unless author.blank?
    "anon-#{@poster.id}"
  end
end
