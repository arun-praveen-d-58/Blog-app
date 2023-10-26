
class PostsController < ApplicationController
  before_action :set_topic
  before_action :set_post, only:[:edit,:update,:show,:destroy,:purge_image]

  def index
    #   @topic = Topic.find(params[:topic_id])

    # Data for Date-picker
    @from_date = params[:from_date] || Date.yesterday
    @to_date = params[:to_date] || Date.today

    @posts = Post.includes(:user,:readers,:tags,:image_attachment).by_date_range(@from_date, @to_date).paginate(page: params[:page], per_page: 10)
    if !(@topic.nil?)
     @posts = @topic.posts.includes(:user,:readers,:tags,:image_attachment).by_date_range(@from_date, @to_date).paginate(page: params[:page], per_page: 10)
    end

  end
  def new
    #  @topic = Topic.find(params[:topic_id])
    @post = !(@topic.nil?) ? @topic.posts.new : Post.new
    #  @rating =  @post.ratings.new
    # @rating_stars = @post.ratings.group(:ratings).count
    set_ratings
  end
  def create
    # @topic = Topic.find(params[:topic_id])
    # @post = @topic.posts.build(params.require(:post).permit(:name,:caption))

    if @topic!=nil
      # @post.tags = post_params[:tag_ids].split(/\s+/).uniq.map { |tag_id| Tag.find_or_create_by(name: tag_id) }
      @post = @topic.posts.build(post_params)
      @post.user = current_user
      set_tag
      respond_to do |format|
      if @post.save
        format.html{redirect_to topic_posts_path(@topic)}
        format.js


      else
        format.html{ render 'new', status: :unprocessable_entity}
      end
        end
    else
      @post = Post.new(post_params)
      @post.topic = nil
      @post.user = current_user
      set_tag
      respond_to do |format|
        if @post.save

          flash[:notice] = "Post was successfully created"
          format.html { redirect_to posts_path}
          format.js
        else
          format.html { render 'new', status: :unprocessable_entity}
        end
    end
    end
  end


  def edit
    # @topic = Topic.find(params[:topic_id])
    # @post = @topic.posts.find(params[:id])
    #  @rating =  @post.ratings.new
    # @rating_stars = @post.ratings.group(:ratings).count
    authorize! :edit, @post
    set_ratings
  end

  def update
    # @topic = Topic.find(params[:topic_id])
    # @post = @topic.posts.find(params[:id])

    authorize! :update, @post

    if @post.update(post_params)
      set_tag
      flash[:notice] = "Post was successfully updated"
      redirect_to (@topic.nil? ? post_path(@post):topic_post_path(@topic))

    else

      render 'edit', status: :unprocessable_entity
    end
  end

  def show
    # @topic = Topic.find(params[:topic_id])
    # @post = @topic.posts.find(params[:id])
    # if !current_user.read_posts.include?(@post)
    #current_user.read_posts << @post
    #end
    #@read_status = @post.Read_status_entry(current_user)
    
    @comment = @post.comments.new

    @comment_rating = @comment.user_comment_ratings.new
    #@rating =  @post.ratings.new
    # @rating_stars = @post.ratings.group(:ratings).count

    #user post rating
    post_rating = @post.ratings.find_by(user: current_user)
    @user_post_rating = !post_rating.nil? ? post_rating.ratings : 0

    #user comment rating
    @user_comment_ratings = {}

    @post.comments.each do |comment|
      user_rating = comment.user_comment_ratings.find_by(user_id: current_user.id)
      if !user_rating.nil?
      @user_comment_ratings[comment.id] = user_rating.ratings
      end
    end
    set_ratings
  end

  def destroy

    # @topic = Topic.find(params[:topic_id])
    # @post = @topic.posts.find(params[:id])
     authorize! :destroy, @post
    @post.destroy
    redirect_to (@topic.nil? ? posts_path : topic_posts_path(@topic))
  end

  def mark_as_read
    post = Post.find(mark_as_read_params[:post_id])
    current_user.read_posts << post
    render json: { success: true }
  end

  def purge_image
     @post.image.purge_later
     redirect_to request.referer
  end

  private

  def set_topic
    if !params[:topic_id].nil?
     @topic = Topic.find(params[:topic_id])
     end
  end
  def set_ratings
    @rating = @post.ratings.new
    @rating_stars = @post.ratings.group(:ratings).count

  end
  def set_post

    if !params[:topic_id].nil?
      @topic = Topic.find(params[:topic_id])
      @post = @topic.posts.includes(:user, :comments).find(params[:id])
    else
      @post = Post.includes(:user, :comments).find(params[:id])
    end

  end

  def set_tag
    tag_name = params[:post][:tag][:name]
    if tag_name.length > 1
      tag = Tag.find_or_create_by(name: tag_name)
      @post.tags << tag
    end
  end


  def post_params
    params.require(:post).permit(:name,:caption,:image,tag_ids:[], tags_attributes: [:id, :name])
  end

  def mark_as_read_params
    params.permit(:post_id)
  end
 
end