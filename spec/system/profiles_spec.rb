require 'rails_helper'

RSpec.describe 'Profiles', type: :system do
  let(:user) { create(:user) }

  before do
    sign_in user
  end

  describe 'profile editing' do
    let(:new_username) { 'username' }

    it 'should take me back to my profile' do
      visit edit_profile_path


      fill_in 'Username', with: new_username

      click_button 'Save changes'

      expect(page).to have_content new_username
    end
  end
end
