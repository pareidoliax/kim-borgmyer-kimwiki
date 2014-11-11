class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def hello
    render text: "<h1>KimWiki</h1><p>Please excuse our mess while we build the site!</p>"
  end
end
