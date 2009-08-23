class WelcomeController < ApplicationController
  def index
  end

  def goto_chat
    puts params.inspect
    redirect_to "/#{params['chat_name'].downcase.gsub(/\W/,'-')}"
  end

end
