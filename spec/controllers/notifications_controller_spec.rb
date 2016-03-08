require 'rails_helper'

RSpec.describe NotificationsController do
  describe 'GET index' do
    let(:user) { create(:user) }
    let!(:read_notification) { create(:notification, :read, user: user) }
    let!(:old_read_notification) do
      create(:notification, :read, user: user, created_at: 2.days.ago)
    end
    let!(:unread_notification) { create(:notification, :read, user: user) }

    before do
      sign_in_as user
    end

    it 'shows unread and newer first' do
      expected = [unread_notification, read_notification, old_read_notification]
      get :index
      expect(assigns(:notifications)).to eq(expected)
    end
  end
end
