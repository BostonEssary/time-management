require 'rails_helper'

RSpec.describe 'Follows', type: :system do
  let(:user) { create(:user) }
  let(:user1) { create(:user) }
  let(:user1_followers) { user1.followers.count }

  before do
    sign_in user
  end

  it 'adds a follower when the follow button is clicked and deletes one when the unfollow button is clicked' do
    visit user_path(user1)

    click_button 'Follow'

    expect(page).to have_content user1.followers.count

    click_button 'Unfollow'

    expect(page).to have_content user1.followers.count
  end
end
