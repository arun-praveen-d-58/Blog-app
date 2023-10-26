class Post < ApplicationRecord
  belongs_to :topic, optional: true
  belongs_to :user
  has_one_attached :image do |attachable|
    attachable.variant :thumb, resize_to_limit: [300, 300]
  end

  has_many :comments, dependent: :destroy
  has_many :ratings, dependent: :destroy
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags, dependent: :destroy
  validates :name, presence:true, length:{minimum: 4, maximum: 20}

  accepts_nested_attributes_for :tags



 has_many :posts_users_read_statuses , dependent: :destroy
  has_many :readers, through: :posts_users_read_statuses, source: :user

  scope :by_date_range, ->(from_date, to_date) {

    from_date = Date.parse(from_date) if from_date.is_a?(String)
    to_date = Date.parse(to_date) if to_date.is_a?(String)

    where("created_at >= ? AND created_at <= ?", from_date.beginning_of_day, to_date.end_of_day)
  }


  def update_rating_average
    new_rating_average = ratings.average(:ratings).to_f
    update_column(:rating_average, new_rating_average)
  end


end