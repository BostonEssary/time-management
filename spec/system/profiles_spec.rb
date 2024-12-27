require 'rails_helper'

RSpec.describe 'Profiles', type: :system do
  let(:user) { create(:user) }

  before do
    sign_in user
  end

  describe 'profile editing' do
    let(:new_username) { 'username' }
    let(:new_experience_level) { 'Mature' }
    let(:new_preference) { 'Blunt' }

    it 'should take me back to my profile with updated attributes' do
      visit edit_profile_path


      fill_in 'Username', with: new_username
      select new_experience_level, from: 'Experience level'
      check new_preference
      click_button 'Save changes'

      expect(page).to have_content new_username
      expect(page).to have_content new_experience_level
      expect(page).to have_content new_preference
    end

    it 'should rerender the form with errors if no username' do
      visit edit_profile_path

      fill_in 'Username', with: nil

      click_button 'Save changes'

      expect(page).to have_content "Username can't be blank"
    end
  end
end
