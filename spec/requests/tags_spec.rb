require 'rails_helper'
require_relative '../../app/controllers/tags_controller'

RSpec.describe TagsController, type: :controller do
  let(:valid_tag_attributes) { { name: 'TestTag' } }
  let(:user) { create(:user) } # Assuming you have a user factory

  before(:each) do
    sign_in user # Sign in the user before each test
  end

  describe 'GET #index' do
    it 'assigns all tags to @tags' do
      get :index
      expect(assigns(:tags)).to eq(Tag.all)
    end
  end

  describe 'GET #new' do
    it 'assigns a new tag to @tag' do
      get :new
      expect(assigns(:tag)).to be_a_new(Tag)
    end
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      it 'creates a new tag' do
        expect {
          post :create, params: { tag: valid_tag_attributes }
        }.to change(Tag, :count).by(1)
      end

      it 'redirects to tags index page' do
        post :create, params: { tag: valid_tag_attributes }
        expect(response).to redirect_to(tags_path)
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new tag' do
        expect {
          post :create, params: { tag: { name: '' } }
        }.to_not change(Tag, :count)
      end

      it 'renders the new template with errors' do
        post :create, params: { tag: { name: '' } }
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'GET #edit' do
    it 'assigns the requested tag to @tag' do
      tag = Tag.create(valid_tag_attributes)
      get :edit, params: { id: tag.id }
      expect(assigns(:tag)).to eq(tag)
    end
  end

  describe 'PATCH #update' do
    let(:updated_tag_attributes) { { name: 'UpdatedTag' } }

    context 'with valid attributes' do
      it 'updates the requested tag' do
        tag = Tag.create(valid_tag_attributes)
        patch :update, params: { id: tag.id, tag: updated_tag_attributes }
        tag.reload
        expect(tag.name).to eq(updated_tag_attributes[:name])
      end

      it 'redirects to tags index page' do
        tag = Tag.create(valid_tag_attributes)
        patch :update, params: { id: tag.id, tag: updated_tag_attributes }
        expect(response).to redirect_to(tags_path)
      end
    end

    context 'with invalid attributes' do
      it 'does not update the requested tag' do
        tag = Tag.create(valid_tag_attributes)
        patch :update, params: { id: tag.id, tag: { name: '' } }
        tag.reload
        expect(tag.name).not_to eq('')
      end

      it 'renders the edit template with errors' do
        tag = Tag.create(valid_tag_attributes)
        patch :update, params: { id: tag.id, tag: { name: '' } }
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested tag' do
      tag = Tag.create(valid_tag_attributes)
      expect {
        delete :destroy, params: { id: tag.id }
      }.to change(Tag, :count).by(-1)
    end

    it 'redirects to tags index page' do
      tag = Tag.create(valid_tag_attributes)
      delete :destroy, params: { id: tag.id }
      expect(response).to redirect_to(tags_path)
    end
  end
end
