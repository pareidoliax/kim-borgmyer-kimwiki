class Wikis::CollaborationsController < ApplicationController
  helper_method :sort_column, :sort_direction

  def index
    @users = User.where.not(id: current_user).paginate(page: params[:page], per_page: 10).order(sort_column + " " + sort_direction)
    @wiki = Wiki.find(params[:wiki_id])
  end

  def update
    @wiki = Wiki.find params[:wiki_id]
    authorize @wiki

    @wiki.user_ids = params[:wiki][:user_ids]

    if @wiki.update_attributes(wiki_params)
      flash[:notice] = "Wiki updated."
      redirect_to wikis_path
    else
      flash[:error] = "Error saving wiki; please try again."
      render :edit
    end

  end

  private

  def sort_column
    User.column_names.include?(params[:sort]) ? params[:sort] : "name"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

  def wiki_params
    params.require(:wiki).permit(:title, :body, :public)
  end
end
