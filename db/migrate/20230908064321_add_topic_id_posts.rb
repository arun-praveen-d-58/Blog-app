class AddTopicIdPosts < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :topic_id, :int
  end
end
