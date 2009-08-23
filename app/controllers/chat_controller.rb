require 'cgi'

class ChatController < ApplicationController
  before_filter :get_chat

  def show
    puts "show:0 chat:#{@chat.inspect}"
    puts params.inspect
    # add message (Chat will ingnore if message body is empty)
    @chat.add_post(params['author'], params['msg'], request.remote_ip)

    puts "show:1"
    if after = params['after']
      render :text => row_html_for_posts_after(after)
    end
  end

  def row_html_for_posts_after last_post
    if last_post =~ /post-(\d+)/
      last_post_id= $1.to_i
      Post.find(
        :all,
        :conditions=> ['chat_id= ? AND id > ?',
          @chat.id,
          last_post_id]).map do |post|
            <<-HTML
              <tr id="poster-#{post.poster_id}">
                <td>#{CGI.escapeHTML(post.author)}</td>
                <td id="post-#{post.id}">#{CGI.escapeHTML(post.msg)}</td>
              </tr>
            HTML
          end.join("\n")
      end
  end

  private

  def get_chat
    puts "get_chat"
    @chat ||= Chat.find_or_create_by_url(params['chat_url'])
  end

end
