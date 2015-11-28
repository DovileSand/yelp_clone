require 'rails_helper'

feature 'endorsing reviews' do
  before do
    ovens = Restaurant.create(name: 'Ovens')
    ovens.reviews.create(rating: 3, thoughts: 'Let me think...')
  end

  scenario 'a user can endore a review, which updates the review endorsement count', js: true do
    visit '/restaurants'
    click_link 'Endorse Review'
    expect(page).to have_content('1 endorsement')
  end
end
