require 'rails_helper'
require_relative '../../app/controllers/posts_controller'


RSpec.describe PostsController, type: :controller do
  let(:valid_topic_attributes) { { title: 'Test Topic', description: 'new description' } }
  let(:valid_post_attributes) { { name: 'New Post', caption: 'New caption' } }
  let(:user) { create(:user) } # Assuming you have a user factory

  before(:each) do
    @topic = Topic.create(valid_topic_attributes)
    @tag = Tag.create(name: 'test_tag')
  end

  before(:all) do
    # Create 15 posts for testing pagination
    @topic_pg = Topic.create(title: 'Test title', description: 'Test description')
    15.times { |i| @topic_pg.posts.create(name: "Post #{i}") }
  end

  describe 'GET #index' do
    context 'when a user is not logged in' do
      it 'redirects to the login page' do
        get :index, params: { topic_id: @topic_pg.id, page: 1 }
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context 'when a user is logged in' do
      before { sign_in user }

      it 'assigns the first page of posts to @posts' do
        get :index, params: { topic_id: @topic_pg.id, page: 1 }
        expect(assigns(:posts).length).to eq(10) # 10 posts per page
      end

      it 'assigns the second page of posts to @posts' do
        get :index, params: { topic_id: @topic_pg.id, page: 2 }
        expect(assigns(:posts).length).to eq(5) # last page with remaining posts
      end
    end
  end

  # Update other actions in a similar manner, adding context for authentication.
  # ...

  describe 'DELETE #destroy' do
    context 'when a user is not logged in' do
      it 'redirects to the login page' do
        post = @topic.posts.create(valid_post_attributes)
        delete :destroy, params: { topic_id: @topic.id, id: post.id }
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context 'when a user is logged in' do
      before { sign_in user }

      it 'destroys the requested post' do
        post = @topic.posts.create(valid_post_attributes)
        expect {
          delete :destroy, params: { topic_id: @topic.id, id: post.id }
        }.to change(Post, :count).by(-1)
      end

      it 'redirects to the topic posts index' do
        post = @topic.posts.create(valid_post_attributes)
        delete :destroy, params: { topic_id: @topic.id, id: post.id, tag_ids: [@tag.id] }
        expect(response).to redirect_to(topic_posts_path(@topic))
      end
    end
  end
end
