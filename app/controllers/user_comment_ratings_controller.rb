class UserCommentRatingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_comment
  before_action :set_topic
  before_action :set_post
  def index
    # @comment = Comment.find(params[:comment_id])
    @user_comment_ratings = @comment.user_comment_ratings.all
  end

  def create
    # @comment = Comment.find(params[:comment_id])
    @rating = !@comment.user_comment_ratings.find_by(user: current_user).nil? ? @comment.user_comment_ratings.find_by(user: current_user) : UserCommentRating.new(rating_params)
   
    if @rating.id.nil?
       @rating.user = current_user
       @rating.comment = @comment

        if @rating.save
          flash[:notice] = "Thanks for your review"
          redirect_to (@topic.nil? ? post_path(@post):topic_post_path(@topic,@post))
        else
          render 'posts/show', status: :unprocessable_entity
        end
    else
      if @rating.update(rating_params)
        flash[:notice] = "Updated successfully!"
        redirect_to (@topic.nil? ? post_path(@post) : topic_post_path(@topic,@post))
      else
        render 'posts/show', status: :unprocessable_entity
      end
    end

  end


  private

  def set_topic
    if !params[:topic_id].nil?
      @topic = Topic.find(params[:topic_id])
    end
  end

  def set_post
    if !params[:topic_id].nil?
      @topic = Topic.find(params[:topic_id])
      @post = @topic.posts.find(params[:post_id])
    else
      @post = Post.find(params[:post_id])
    end
  end
  def set_comment
    @comment = Comment.find(params[:comment_id])
  end

  def rating_params
    params.require(:user_comment_rating).permit(:ratings)
  end
end