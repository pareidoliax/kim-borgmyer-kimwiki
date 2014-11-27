class Wikis::CollaborationsController < ApplicationController
  def index
    @users = User.where.not(premium: nil).where.not(id: current_user).paginate(page: params[:page], per_page: 10)
    @wiki = Wiki.find(params[:wiki_id])
  end
end
