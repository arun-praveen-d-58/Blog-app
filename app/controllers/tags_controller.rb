class TagsController < ApplicationController
  before_action :set_tag, only:[:edit,:update,:show,:destroy]
  before_action :tag_params, only:[:create,:update]

  def index
    @tags = Tag.all
  end
  def new 
    @tag = Tag.new
  end
  def create
    @tag = Tag.create(tag_params)
    if @tag.save
      flash[:notice] = "Tag created successfully"
      redirect_to tags_path
    else
      render 'new', status: :unprocessable_entity
    end
  end

  def edit
    #@tag = Tag.find(params[:id])
  end

  def update
    #@tag = Tag.find(params[:id])

    if @tag.update(tag_params)
      flash[:notice] = "Tag name updated successfully"
      redirect_to tags_path
    else
      render 'edit', status: :unprocessable_entity
    end
  end

  def destroy
    #@tag = Tag.find(params[:id])
     @tag.destroy
    redirect_to tags_path
  end

  def show
    #@tag = Tag.find(params[:id])
  end

  private
  def set_tag
    @tag = Tag.find(params[:id])
  end

  def tag_params
    params.require(:tag).permit(:name)
  end
end