class AddDefaultToRatingAverage < ActiveRecord::Migration[7.0]
  def change
    change_column_default :posts, :rating_average, 0.0
  end
end
