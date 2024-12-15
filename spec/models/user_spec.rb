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
end
