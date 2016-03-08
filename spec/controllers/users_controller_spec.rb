require 'rails_helper'

RSpec.describe UsersController do
  describe 'PUT follow' do
    let!(:user_to_follow) { create(:user) }
    let!(:user) { create(:user) }

    before do
      sign_in_as user
    end

    subject(:put_follow) do
      put :follow, username: user_to_follow.username
    end

    it 'creates a relationship' do
      put_follow
      user.reload
      expect(user.following).to include(user_to_follow)
    end
  end

  describe 'PUT unfollow' do
    let!(:user_to_unfollow) { create(:user) }
    let!(:user) { create(:user) }

    before do
      user.follow user_to_unfollow
      sign_in_as user
    end

    subject(:put_unfollow) do
      put :unfollow, username: user_to_unfollow.username
    end

    it 'deletes the relationship' do
      put_unfollow
      user.reload
      expect(user.following).not_to include(user_to_unfollow)
    end
  end
end
