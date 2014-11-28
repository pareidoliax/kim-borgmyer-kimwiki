class Wikis::CollaborationsController < ApplicationController
  helper_method :sort_column, :sort_direction

  def index
    @users = User.where.not(premium: nil).where.not(id: current_user).paginate(page: params[:page], per_page: 10).order(sort_column + " " + sort_direction)
    @wiki = Wiki.find(params[:wiki_id])
  end

  private

  def sort_column
    User.column_names.include?(params[:sort]) ? params[:sort] : "name"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
end
