require 'rails_helper'

RSpec.describe 'User Registration', type: :system do
  it 'creates a new user' do
    visit new_user_registration_path

    fill_in 'Username', with: 'username'
    fill_in 'Email', with: 'email@email.com'
    fill_in 'Date of birth', with: 21.years.ago
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'

    click_button 'Sign up'

    expect(page).to have_text('Dashboard')
  end
end
