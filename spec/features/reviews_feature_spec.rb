require 'rails_helper'

context 'reviewing:' do
  before {Restaurant.create name: 'Ovens'}

  scenario 'allows users to leave a review using a form' do
    leave_review('awesome', '4')
    expect(current_path).to eq '/restaurants'
    expect(page).to have_content('awesome')
  end

  scenario 'displays an average rating for all reviews' do
    leave_review('So so', '3')
    leave_review('Great', '5')
    visit('/restaurants')
    expect(page).to have_content('Average rating: 4')
  end

  # scenario 'cannot delete review that user did not create' do
  #   sign_in
  #   visit '/restaurants'
  #   click_link 'Review Ovens'
  #   fill_in "Thoughts", with: "awesome"
  #   select '4', from: 'Rating'
  #   click_button 'Leave Review'
  #   click_link('Sign out')
  #   sign_in(email: "test2@test.com", password: "password2")
  #   visit '/restaurants'
  #   click_link ''
  #   expect(page).to have_content 'You cannot delete restaurant that you did not create'
  # end
end
