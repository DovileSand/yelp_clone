require 'rails_helper'

feature 'restaurants:' do
  context 'no restaurants have been added:' do
    scenario 'should display a prompt to add a restaurant' do
      visit '/restaurants'
      expect(page).to have_content 'No restaurants yet'
      expect(page).to have_link 'Add restaurant'
    end
  end

  context 'restaurants have been added:' do
    before do
      Restaurant.create(name: 'Ovens')
    end

    scenario 'display restaurants' do
      visit '/restaurants'
      expect(page).to have_content('Ovens')
      expect(page).not_to have_content('No restaurants yet')
    end
  end

  context 'creating restaurants:' do
    scenario 'prompts user to fill out a form then displays the new restaurant' do
      visit '/restaurants'
      sign_in
      click_link 'Add restaurant'
      fill_in 'Name', with: 'Ovens'
      click_button 'Create Restaurant'
      expect(page).to have_content 'Ovens'
      expect(current_path).to eq '/restaurants'
    end

   context 'an invalid restaurant:' do
     it 'does not let you submit a name that is too short' do
       visit '/restaurants'
       sign_in
       click_link 'Add restaurant'
       fill_in 'Name', with: 'Ov'
       click_button 'Create Restaurant'
       expect(page).not_to have_css 'h2', text: 'Ov'
       expect(page).to have_content 'error'
     end
   end
  end

  context 'viewing restaurants:' do
    let!(:ovens){Restaurant.create(name:'Ovens')}
    scenario 'lets a user view a restaurant' do
      visit '/restaurants'
      click_link 'Ovens'
      expect(page).to have_content 'Ovens'
      expect(current_path).to eq "/restaurants/#{ovens.id}"
    end
  end

  context 'editing restaurants:' do
    scenario 'lets a user edit a restaurant' do
      visit '/restaurants'
      sign_in
      create_restaurant
      click_link 'Edit Ovens'
      fill_in 'Name', with: "Best Aubergine Bakes"
      click_button 'Update Restaurant'
      expect(page).to have_content 'Best Aubergine Bakes'
      expect(current_path).to eq '/restaurants'
    end

    scenario 'cannot edit restaurant when user did not create restaurant' do
      sign_in
      visit '/restaurants'
      click_link 'Add restaurant'
      fill_in 'Name', with: 'MUMs'
      click_button 'Create Restaurant'
      click_link('Sign out')
      sign_in(email: "test2@test.com", password: "password2")
      visit '/restaurants'
      click_link 'Edit MUMs'
      fill_in 'Name', with: 'new_MUMs'
      click_button 'Update Restaurant'
      expect(page).to have_content 'You cannot edit restaurant that you did not create'
    end
  end

  context 'deleting restaurants:' do
    scenario 'removes a restaurant when a user clicks a delete link' do
      visit '/restaurants'
      sign_in
      create_restaurant
      click_link 'Delete Ovens'
      expect(page).not_to have_content 'Ovens'
      expect(page).to have_content 'Restaurant deleted successfully'
    end

    scenario 'cannot delete restaurant when user did not create restaurant' do
      sign_in
      visit '/restaurants'
      click_link 'Add restaurant'
      fill_in 'Name', with: 'MUMs'
      click_button 'Create Restaurant'
      click_link('Sign out')
      sign_in(email: "test2@test.com", password: "password2")
      visit '/restaurants'
      click_link 'Delete MUMs'
      expect(page).to have_content 'You cannot delete restaurant that you did not create'
    end
  end
end
