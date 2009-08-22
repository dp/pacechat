class Chat < ActiveRecord::Base
  has_many :posts

  def add_post author, msg, ipaddress
    unless msg.strip.empty?
      self.posts.create(
        :author=>author,
        :msg=> msg,
        :poster=> Poster.find_or_create_by_ipaddress(ipaddress))
    end
  end
end
