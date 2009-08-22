class ChatController < ApplicationController
  def show
    @url= "****"+ params['chat_url']
    puts "****#{@url}"
    @x= "something"
  end

end
