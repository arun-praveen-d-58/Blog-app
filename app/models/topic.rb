class Topic < ApplicationRecord
  has_many :posts, dependent: :destroy
  validates :title, presence: true, length: {minimum:3,maximum:10}
  validates :description,presence: true,length: {minimum:6,maximum:50}
end
