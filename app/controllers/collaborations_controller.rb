class CollaborationsController < ApplicationController
  def create
    @wiki.user_ids = params[:wiki][:user_ids]
  end
end
