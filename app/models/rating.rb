class Rating < ApplicationRecord
  belongs_to :post
  belongs_to :user
  after_save :update_post_rating_average

  validates :ratings, inclusion: { in: 1..5, message: "Rating must be between 1 and 5" }

  def update_post_rating_average
    post.update_rating_average
  end

end
