require 'rails_helper'

RSpec.feature 'User Sign Out', type: :feature do
  let(:user) { create(:user) } # Assuming you have a Factory for User

  scenario 'User can sign out successfully' do
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'
    visit root_path

    expect(page).to have_link('Sign Out', href: destroy_user_session_path)
  end
end
