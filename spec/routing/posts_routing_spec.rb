require 'rails_helper'

RSpec.describe 'PostsController Routing', type: :routing do
  describe 'nested under topics' do
    it 'routes GET /topics/1/posts to posts#index' do
      expect(get: '/topics/1/posts').to route_to('posts#index', topic_id: '1')
    end

    it 'routes GET /topics/1/posts/new to posts#new' do
      expect(get: '/topics/1/posts/new').to route_to('posts#new', topic_id: '1')
    end

    it 'routes POST /topics/1/posts to posts#create' do
      expect(post: '/topics/1/posts').to route_to('posts#create', topic_id: '1')
    end

    it 'routes GET /topics/1/posts/1/edit to posts#edit' do
      expect(get: '/topics/1/posts/1/edit').to route_to('posts#edit', topic_id: '1', id: '1')
    end

    it 'routes PATCH /topics/1/posts/1 to posts#update' do
      expect(patch: '/topics/1/posts/1').to route_to('posts#update', topic_id: '1', id: '1')
    end

    it 'routes PUT /topics/1/posts/1 to posts#update' do
      expect(put: '/topics/1/posts/1').to route_to('posts#update', topic_id: '1', id: '1')
    end

    it 'routes GET /topics/1/posts/1 to posts#show' do
      expect(get: '/topics/1/posts/1').to route_to('posts#show', topic_id: '1', id: '1')
    end

    it 'routes DELETE /topics/1/posts/1 to posts#destroy' do
      expect(delete: '/topics/1/posts/1').to route_to('posts#destroy', topic_id: '1', id: '1')
    end
  end
end
