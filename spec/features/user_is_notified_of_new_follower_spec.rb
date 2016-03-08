require 'rails_helper'

RSpec.feature 'User is notified of new follower' do
  given!(:user) { create(:user) }
  given!(:follower) { create(:user) }

  background do
    follower.follow(user)
    visit notifications_path(as: user)
  end

  it 'shows the new follower notification' do
    expect_page_to_display_new_follower_notification
  end

  it 'shows a link to the follower' do
    expect_page_to_have_link_to_follower
  end

  private

  def expect_page_to_display_new_follower_notification
    message = I18n.t(:new_follower, scope: [:notifications, :messages])
    expect(page).to have_content(message)
  end

  def expect_page_to_have_link_to_follower
    expect(page)
      .to have_link("@#{follower.username}", user_path(follower.username))
  end
end
