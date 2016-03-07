require 'rails_helper'

RSpec.feature 'Visitor views a post' do
  given!(:post) { create(:post) }

  background do
    visit post_path(post.username, post)
  end

  scenario 'views the post content' do
    expect(page).to have_content(post.content)
  end

  scenario 'has a link to the profile of the author' do
    user = post.user
    expect(page)
      .to have_link(user.username, href: user_path(user.username))
  end
end
