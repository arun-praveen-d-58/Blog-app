class RatingsController < ApplicationController
  before_action :set_post

  def create
    @rating = !@post.ratings.find_by(user: current_user).nil? ? @post.ratings.find_by(user: current_user) : Rating.new(rating_params)

    if @rating.id.nil?
      @rating.post_id = @post.id
      @rating.user_id = current_user.id

      if @rating.save
        flash[:notice] = "Thanks for your review"
        redirect_to request.referer
      else
        # flash[:alert] = "Minimum rating must be 1"
        render 'posts/show', status: :unprocessable_entity
      end
    else
      if @rating.update(rating_params)
        flash[:notice] = "Updated successfully!"
        redirect_to request.referer
      else
        render 'posts/show', status: :unprocessable_entity
      end
    end
  end


  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def rating_params
    params.require(:rating).permit(:ratings)
  end
  
end