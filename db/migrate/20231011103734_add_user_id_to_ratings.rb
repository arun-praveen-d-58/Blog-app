class AddUserIdToRatings < ActiveRecord::Migration[7.0]
  def change
    add_column :ratings,:user_id,:int
  end
end
