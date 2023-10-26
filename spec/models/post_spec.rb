
require 'rails_helper'
require_relative '../../app/models/post'

RSpec.describe Post, type: :model do
  before(:each) do
    @topic = Topic.create(title: 'Test Topic', description: 'Test Description')
    @post = Post.new(name: 'Test Name', caption: 'Test Caption', topic: @topic)
  end
  describe 'name and caption validation' do
  it 'is valid with valid attributes' do
    expect(@post).to be_valid
  end

  it 'is should consist of minimum 4 and maximum 20 characters' do
    @post.name = "xxx"
    expect(@post).to_not be_valid

    @post.name = "x"*21
    expect(@post).to_not be_valid

    @post.name = "xxxxxxxxx"
    expect(@post).to be_valid
    end
  end

  describe 'image attachment' do
    it 'is valid when an image is attached' do
      post = FactoryBot.build(:post_with_image)
      expect(post).to be_valid
    end

    #it 'is invalid when no image is attached' do
    #  post = FactoryBot.build(:post)
    #  expect(post).not_to be_valid
    #end
  end
end
