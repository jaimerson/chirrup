require 'rails_helper'

RSpec.feature 'User posts an update' do
  given(:user) { create(:user) }

  background do
    visit root_path(as: user)
  end

  scenario 'by typing on the textbox on home page' do
    write_post 'Today I saw a monkey on the pole'
    send_post
    expect_content_on_timeline 'Today I saw a monkey on the pole'
  end

  private

  def write_post(content)
    fill_in 'post[content]', with: content
  end

  def send_post
    find('#chirp-btn').click
  end

  def expect_content_on_timeline(content)
    expect(page).to have_content(content)
  end
end
