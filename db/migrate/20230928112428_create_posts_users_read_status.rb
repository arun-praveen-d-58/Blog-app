class CreatePostsUsersReadStatus < ActiveRecord::Migration[7.0]
  def change
    create_table :posts_users_read_statuses do |t|
      t.references :user, foreign_key: true
      t.references :post, foreign_key: true
      t.timestamps
    end
    add_index :posts_users_read_statuses, [:user_id, :post_id], unique: true
  end
end
