class WikisController < ApplicationController
  def create
    @wiki = Wiki.new(params.require(:wiki).permit(:title, :body, :public))

    if @wiki.save
      flash[:notice] = "Wiki saved."
      redirect_to @wiki
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
      flash[:notice] = "\"#{title}\" deleted successfully."
      redirect_to wikis_path
    else
      flash[:notice] = "\"#{title}\" not deleted."
      render :show
    end
  end

  def edit
    @wiki = Wiki.find(params[:id])
  end

  def index
    @wikis = Wiki.paginate(page: params[:page], per_page: 10)
  end

  def new
    @wiki = Wiki.new
  end

  def show
    @wiki = Wiki.find(params[:id])
  end

  def update
    @wiki = Wiki.find(params[:id])

    if @wiki.update_attributes(params.require(:wiki).permit(:title, :body, :public))
      flash[:notice] = "Wiki updated."
      redirect_to @wiki
    else
      flash[:error] = "Error saving wiki; please try again."
      render :edit
    end
  end
end
