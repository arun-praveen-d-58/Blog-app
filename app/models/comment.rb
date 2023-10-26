class Comment < ApplicationRecord
  belongs_to :post, counter_cache: true

  belongs_to :user

  has_many :user_comment_ratings, dependent: :destroy
  has_many :rated_users, through: :user_comment_ratings, source: :user

  validates :context, length:{minimum: 1,maximum: 200}
end