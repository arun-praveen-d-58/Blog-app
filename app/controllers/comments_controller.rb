 class CommentsController < ApplicationController
   before_action :set_topic
  before_action :set_post, only:[:index,:create,:edit,:update]
  before_action :set_comment, only:[:edit,:update]


  def index
    # @post = Post.find(params[:post_id])
    @comments = @post.comments.all
    render 'posts/show'
  end
  
  #def show
  #  @post = Post.find(params[:post_id])
  #  @comment = @post.comments.find(params[:id])
  #end
  
  #def new
  #  @post = Post.find(params[:post_id])
  #  @comment = @post.comments.new
  #end
  
  def create
    #@post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.context = @comment.context.strip
    @comment.user = current_user
    # @post.comments_count+=1
    # puts @post.comments_count.inspect
    if @comment.save
      flash[:notice] = "Comment added successfully"
      redirect_to ! @post.topic.nil? ? topic_post_path(@post.topic,@post) : post_path(@post)
    else
      render 'posts/show',status: :unprocessable_entity
    end

  end
  
  def edit
    #@post = Post.find(params[:post_id])
    #@comment = @post.comments.find(params[:id])
    @comment_rating = @comment.user_comment_ratings.find_by(user_id: current_user.id)
    authorize! :edit, @comment
    render 'posts/show'
  end
  
  def update
    #@post = Post.find(params[:post_id])
    # @comment = @post.comments.find(params[:id])
    authorize! :update, @comment
    comment_params[:context] = comment_params[:context].strip
    if @comment.update(comment_params)
      flash[:notice] = "Comment updated successfully"
      redirect_to @topic.nil? ? post_path(@post) : topic_post_path(@topic,@post)
    else
      render 'posts/show',status: :unprocessable_entity
    end
  end

  def destroy
    @comment = Comment.find(params[:id])

    authorize! :destroy, @comment

    @comment.destroy
    redirect_to post_path(@comment.post.id)
  end

  private

  def set_topic
    if !params[:topic_id].nil?
      @topic = Topic.find(params[:topic_id])
    end
  end
  def set_post
    @post = Post.find(params[:post_id])
    @rating = @post.ratings.new
    @rating_stars = @post.ratings.group(:ratings).count
  end
  def set_comment
    @comment = @post.comments.find(params[:id])
  end


  def comment_params
    params.require(:comment).permit(:context)
  end


end
