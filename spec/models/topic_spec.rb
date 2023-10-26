require 'rails_helper'

RSpec.describe Topic, type: :model do
  before(:each) do
   @topic = Topic.new(title:"Test Topic", description:"Description of test topic")
  end

  it 'is valid with all attributes' do
    expect(@topic).to be_valid
  end
  it 'is not valid without a title' do
    @topic.title = ''
    expect(@topic).to_not be_valid
  end

  it 'is not valid without a description' do
    @topic.description = ''
    expect(@topic).to_not be_valid
  end


  it 'must contain title with minimum 3 to maximum 10 characters' do
   @topic.title = 'xx'
   expect(@topic).to_not be_valid

   @topic.title = 'xxxxxxxxxxx'
   expect(@topic).to_not be_valid

   @topic.title = 'xxxx'
   expect(@topic).to be_valid
  end

  it 'must contain description with minimum 3 to maximum 10 characters' do
    @topic.description = 'xxxxx'
    expect(@topic).to_not be_valid

    @topic.description = 'x'*101
    expect(@topic).to_not be_valid

    @topic.description = 'xxxxxxxx'
    expect(@topic).to be_valid
  end

end
