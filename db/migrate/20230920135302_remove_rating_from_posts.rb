class RemoveRatingFromPosts < ActiveRecord::Migration[7.0]
  def change
    safety_assured { remove_column :posts, :ratings }

  end
end
