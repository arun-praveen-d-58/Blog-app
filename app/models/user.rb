class User < ApplicationRecord
  has_many :posts,dependent: :destroy
  has_many :comments , dependent: :destroy
  has_many :ratings, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  #has_and_belongs_to_many :read_posts, class_name: 'Post', join_table: 'posts_users_read_statuses'
 has_many :posts_users_read_statuses ,dependent: :destroy
  has_many :read_posts, through: :posts_users_read_statuses, source: :post

  has_many :user_comment_ratings ,dependent: :destroy
  has_many :rated_comments, through: :user_comment_ratings, source: :comment


end
