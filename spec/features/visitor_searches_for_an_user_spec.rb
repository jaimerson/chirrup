require 'rails_helper'

RSpec.feature 'User searches for an user' do
  given(:user) { create(:user) }
  given!(:user_to_show) { create(:user, username: 'Roberto') }
  given!(:user_to_hide) { create(:user, username: 'Joaquina') }

  background do
    visit root_path(as: user)
  end

  scenario 'shows the user searched for' do
    search_for 'Roebrto'
    expect(page).to have_content('Roberto')
    expect(page).not_to have_content('Joaquina')
  end

  private

  def search_for(name)
    fill_in 'search', with: name
    submit_form('search-form')
  end
end
