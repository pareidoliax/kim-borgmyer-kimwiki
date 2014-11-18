class WikisController < ApplicationController
  def destroy
    @wiki = Wiki.find(params[:id])
    title = @wiki.title

    authorize @wiki
    if @wiki.destroy
      flash[:notice] = "\"#{title}\" deleted successfully."
      redirect_to wikis_path
    else
      flash[:notice] = "\"#{title}\" not deleted."
      render :show
    end
  end

  def index
    @wikis = Wiki.paginate(page: params[:page], per_page: 10)
  end

  def show
    @wiki = Wiki.find(params[:id])
  end

  def new
  end

  def edit
  end
end
