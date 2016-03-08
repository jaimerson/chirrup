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
end
