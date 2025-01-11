# == Schema Information
#
# Table name: users
#
#  id                      :bigint           not null, primary key
#  consumption_preferences :string           default([]), is an Array
#  date_of_birth           :date
#  email                   :string           default(""), not null
#  encrypted_password      :string           default(""), not null
#  experience_level        :string
#  remember_created_at     :datetime
#  reset_password_sent_at  :datetime
#  reset_password_token    :string
#  username                :string
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_username              (username) UNIQUE
#
require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }
  let(:user1) { create(:user) }

  context 'validations' do
    context 'username validations' do
      let(:user2) { build(:user, username: user.username) }

      it 'is not valid if username has been taken' do
        expect(user2).to be_invalid
      end
    end

    context 'email validation' do
      let(:user2) { build(:user) }

      it 'is not valid if the email is empty' do
        user2.email = nil
        expect(user2).to be_invalid
      end

      it 'is not valid if the email is already used' do
        user2.email = user.email
        expect(user2).to be_invalid
      end
    end

    context 'date of birth validation' do
      let(:user2) { build(:user) }

      it 'is not valid if the user is younger than 21' do
        user2.date_of_birth = Date.today - 18.years
        expect(user2).to be_invalid
      end
    end
  end

  context 'associations' do
    context 'follows' do
      let!(:follow) { create(:follow, followee: user, follower: user1) }
      it 'increases follow count when a follow association is made' do
        expect user.followers.count == 1
      end

      it 'increases the following count'
        expect user1.followees.count == 1
      end
    end
  end
end
