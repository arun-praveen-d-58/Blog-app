class CreateUserCommentRatings < ActiveRecord::Migration[7.0]
  def change
    create_table :user_comment_ratings do |t|
      t.references :user, foreign_key: true
      t.references :comment, foreign_key: true
      t.integer :ratings
      t.timestamps
    end
    add_index :user_comment_ratings, [:user_id, :comment_id], unique: true
  end
end
