require 'rails_helper'

feature 'reviewing' do
  before {Restaurant.create name: 'Ovens'}

  scenario 'allows users to leave a review using a form' do
    visit '/restaurants'
    click_link 'Review Ovens'
    fill_in "Thoughts", with: "awesome"
    select '4', from: 'Rating'
    click_button 'Leave Review'

    expect(current_path).to eq '/restaurants'
    expect(page).to have_content('awesome')
  end


end
