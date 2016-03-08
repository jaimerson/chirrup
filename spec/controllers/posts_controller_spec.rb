require 'rails_helper'

RSpec.describe PostsController do
  describe 'GET index' do
    let!(:user) { create(:user) }
    let(:influencer) { create(:user, username: 'tenderlove') }

    before do
      user.follow influencer
      sign_in_as user
    end

    context 'when there are posts from multiple users' do
      let!(:post_to_show) { create(:post, user: influencer) }
      let!(:post_to_hide) { create(:post) }
      let!(:owned_post) { create(:post, user: user) }

      it 'includes the post from the followed user' do
        get :index
        expect(assigns(:posts)).to include(post_to_show)
      end

      it 'includes the post from the himself' do
        get :index
        expect(assigns(:posts)).to include(owned_post)
      end

      it 'does not include the post from someone else' do
        get :index
        expect(assigns(:posts)).not_to include(post_to_hide)
      end

    end
  end
end
