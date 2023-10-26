require 'rails_helper'

RSpec.feature 'User Sign In', type: :feature do
  let(:user) { create(:user) } # Assuming you have a Factory for User

  scenario 'User can sign in with valid credentials' do
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'

    expect(page).to have_content('Signed in successfully.')
  end

  scenario 'User cannot sign in with invalid credentials' do
    visit new_user_session_path
    fill_in 'Email', with: 'nonexistent@example.com'
    fill_in 'Password', with: 'invalid-password'
    click_button 'Log in'

    expect(current_path).to eq(new_user_session_path)
  end
end
