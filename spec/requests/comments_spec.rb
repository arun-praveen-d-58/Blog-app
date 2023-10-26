require 'rails_helper'
require_relative '../../app/controllers/comments_controller'


RSpec.describe CommentsController, type: :controller do
  let(:valid_post_attributes) { { name: "TestPost", caption: "TestCaption" } }
  let(:valid_comment_attributes) { { context: "TestComment" } }
  let(:user) { create(:user) } # Assuming you have a user factory

  before(:each) do
    sign_in user # Sign in the user before each test
    @post = Post.create(valid_post_attributes)
  end

  describe 'GET #index' do
    it 'assigns all the comments of the post to @comment' do
      get :index, params: { post_id: @post.id }
      expect(assigns(:comments)).to eq(@post.comments)
    end
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      it 'creates a new comment to the post' do
        expect {
          post :create, params: { comment: valid_comment_attributes, post_id: @post.id }
        }.to change(Comment, :count).by(1)
      end

      it 'redirects to the same (show post page)' do
        post :create, params: { comment: valid_comment_attributes, post_id: @post.id }
        expect(response).to redirect_to(post_path(@post))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new comment to the post' do
        expect {
          post :create, params: { comment: { context: "" }, post_id: @post.id }
        }.to_not change(Comment, :count)
      end

      it 'renders the show template with errors' do
        post :create, params: { comment: { context: "" }, post_id: @post.id }
        expect(response).to render_template(:show)
      end
    end
  end

  describe 'GET #edit' do
    it 'assigns the requested comment to @comment' do
      @comment = @post.comments.create(valid_comment_attributes)
      get :edit, params: { post_id: @post.id, id: @comment.id }
      expect(assigns(:comment)).to eq(@comment)
    end
  end

  describe 'PATCH #update' do
    let(:updated_comment_attributes) { { context: 'Updated Comment' } }

    context 'with valid attributes' do
      it 'updates the requested comment' do
        @comment = @post.comments.create(valid_comment_attributes)
        patch :update, params: { post_id: @post.id, id: @comment.id, comment: updated_comment_attributes }
        @comment.reload
        expect(@comment.context).to eq(updated_comment_attributes[:context])
      end

      it 'redirects to the same page' do
        @comment = @post.comments.create(valid_comment_attributes)
        patch :update, params: { post_id: @post.id, id: @comment.id, comment: updated_comment_attributes }
        expect(response).to redirect_to(post_path(@post))
      end
    end

    context 'with invalid attributes' do
      it 'does not update the requested comment' do
        @comment = @post.comments.create(valid_comment_attributes)
        patch :update, params: { post_id: @post.id, id: @comment.id, comment: { context: "" } }
        @comment.reload
        expect(@comment.context).not_to eq("")
      end

      it 'renders the show template with errors' do
        @comment = @post.comments.create(valid_comment_attributes)
        patch :update, params: { post_id: @post.id, id: @comment.id, comment: { context: "" } }
        expect(response).to render_template(:show)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested comment' do
      @comment = @post.comments.create(valid_comment_attributes)
      expect {
        delete :destroy, params: { post_id: @post.id, id: @comment.id }
      }.to change(Comment, :count).by(-1)
    end

    it 'redirects to the same page' do
      @comment = @post.comments.create(valid_comment_attributes)
      delete :destroy, params: { post_id: @post.id, id: @comment.id }
      expect(response).to redirect_to(post_path(@post))
    end
  end
end
