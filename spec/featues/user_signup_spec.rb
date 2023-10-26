# spec/features/user_registration_spec.rb

require 'rails_helper'

RSpec.feature 'User Registration', type: :feature do
  scenario 'User can sign up with valid credentials' do
    visit new_user_registration_path
    fill_in 'Email', with: 'user@example.com'
    fill_in 'Password', with: 'password123'
    fill_in 'Password confirmation', with: 'password123'
    click_button 'Sign up'

    expect(page).to have_content('Welcome! You have signed up successfully.')
  end

  scenario 'User cannot sign up with invalid credentials' do
    visit new_user_registration_path
    fill_in 'Email', with: 'invalid-email'
    fill_in 'Password', with: 'short'
    fill_in 'Password confirmation', with: 'different'
    click_button 'Sign up'

    expect(page).to have_content('errors prohibited this user from being saved')
  end
end
