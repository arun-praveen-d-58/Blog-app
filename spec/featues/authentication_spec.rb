require 'rails_helper'

RSpec.feature 'Authentication', type: :feature do
  scenario 'User is redirected to login screen when not logged in' do
    # Visit a page that requires authentication, e.g., the topic page
    visit topics_path

    # Expect to be redirected to the login page
    expect(current_path).to eq(new_user_session_path)
  end
end