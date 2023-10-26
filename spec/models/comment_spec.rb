require 'rails_helper'
require_relative '../../app/models/comment'


RSpec.describe Comment, type: :model do
  before(:each) do
    @post = Post.create(name: 'Test Post', caption: 'Test Caption')
    @comment = Comment.new(context: 'Test Context', post: @post)
  end

  it 'is valid with valid attributes' do
    expect(@comment).to be_valid
  end

  it 'should have a minimum length of 1' do
    @comment.context = ""
    expect(@comment).to_not be_valid
  end

  it 'should have a maximum length of 200' do
    @comment.context = "x" * 201
    expect(@comment).to_not be_valid

    @comment.context = "x" * 200
    expect(@comment).to be_valid
  end

  it 'is not valid without a post' do
    @comment.post = nil
    expect(@comment).to_not be_valid
  end
end
