class Chat < ActiveRecord::Base
  has_many :posts, :order=> 'created_at DESC'

  def add_post author, msg, ipaddress
    puts "** author:#{author.inspect} msg:#{msg.inspect}"
    unless msg.blank?
      self.posts.create(
        :author=> get_author(author, ipaddress),
        :msg=> msg,
        :poster=> @poster || Poster.find_or_create_by_ipaddress(ipaddress))
    end
  end

  def get_author author, ipaddress
    # if no author set to anon n
    return author unless author.blank?
    @poster= Poster.find_or_create_by_ipaddress(ipaddress)
    "anon-#{@poster.id}"
  end
end
