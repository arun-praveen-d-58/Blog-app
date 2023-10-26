class UserCommentRating < ApplicationRecord
  belongs_to :user
  belongs_to :comment
  validates :ratings, inclusion: { in: 1..5, message: "Rating must be between 1 and 5" }
end