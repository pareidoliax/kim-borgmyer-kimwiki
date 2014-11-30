class WikisController < ApplicationController
  include WikisHelper

  def create
    @wiki = Wiki.new(params.require(:wiki).permit(:title, :body, :public))
    @wiki.user = current_user
    authorize @wiki

    if @wiki.save
      flash[:notice] = "Wiki saved."
      redirect_to wikis_path
    else
      flash[:notice] = "Error saving wiki; please try again."
      render :new
    end
  end

  def destroy
    @wiki = Wiki.find(params[:id])
    title = @wiki.title

    authorize @wiki
    if @wiki.destroy
      flash[:notice] = "\"#{title}\" deleted."
      redirect_to wikis_path
    else
      flash[:notice] = "Error deleting \"#{title}\"; please try again."
      render :show
    end
  end

  def edit
    @wiki = Wiki.find(params[:id])
    authorize @wiki
  end

  def index
    @wikis = Wiki.visible_to(current_user).paginate(page: params[:page], per_page: 10)
    authorize @wikis
  end

  def new
    @wiki = Wiki.new
    authorize @wiki
  end

  def show
    @wiki = Wiki.find(params[:id])
  end

  def collaborators
    @wiki = Wiki.find(params[:id])
    @users = User.where.not(premium: nil).where.not(id: current_user.id).paginate(page: params[:page], per_page: 10).order(sort_column + " " + sort_direction)
  end

  def update
    @wiki = Wiki.find(params[:id])
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

  def wiki_params
    params.require(:wiki).permit(:title, :body, :public)
  end
end
