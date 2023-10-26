class AddPostIdToRatings < ActiveRecord::Migration[7.0]
  def change
    add_column :ratings, :post_id, :int
  end
end
