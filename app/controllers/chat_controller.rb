require 'cgi'

class ChatController < ApplicationController
  before_filter :get_chat

  def show
    # add message (Chat will ingnore if message body is empty)
    @chat.add_post(params['author'], params['msg'], request.remote_ip)

    if after = params['after']
      render :text => row_html_for_posts_after(after)
    end
  end

  def row_html_for_posts_after last_post
    last_post_id= (last_post =~ /post-(\d+)/ ? $1.to_i : 0)
    puts "*** #{last_post_id}"
    html= Post.find(
      :all,
      :order=> 'id DESC',
      :conditions=> ['chat_id= ? AND id > ?',
        @chat.id,
        last_post_id]).map do |post|
      if post.poster_id==@poster.id
        post_class="poster-self"
      else
        post_class="poster-#{post.poster_id}"
      end
      puts post_class
      <<-HTML
              <tr class="#{post_class}">
                <td>#{CGI.escapeHTML(post.author)}</td>
                <td id="post-#{post.id}">#{CGI.escapeHTML(post.msg)}</td>
              </tr>
      HTML
    end.join("\n")
    html
  end

  private

  def get_chat
    @poster ||= Poster.find_or_create_by_ipaddress(request.remote_ip)
    @chat ||= Chat.find_or_create_by_url(params['chat_url'].downcase)
  end

end
