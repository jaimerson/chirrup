require 'rails_helper'

RSpec.feature 'Visitor views an user profile with posts' do
  given!(:user) { create(:user) }
  given!(:user_posts) { create_list(:post, 2, user: user) }
  given!(:other_posts) { create_list(:post, 2) }

  background do
    visit user_path(user.username)
  end

  scenario 'views the username' do
    expect(page).to have_content(user.username)
  end

  scenario 'views all the user posts' do
    expect_posts_to_be_shown(user_posts)
  end

  scenario 'only shows that users posts' do
    expect_posts_not_to_be_shown(other_posts)
  end

  private

  def expect_posts_to_be_shown(posts)
    posts.each do |post|
      expect(page).to have_content(post.content)
    end
  end

  def expect_posts_not_to_be_shown(posts)
    posts.each do |post|
      expect(page).not_to have_content(post.content)
    end
  end
end
