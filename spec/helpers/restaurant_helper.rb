def create_restaurant
  visit '/restaurants'
  click_link 'Add restaurant'
  fill_in 'Name', with: 'Ovens'
  click_button 'Create Restaurant'
end
