require 'rails_helper'

feature 'restaurants:' do
  context 'no restaurants have been added' do
    scenario 'should display a prompt to add a restaurant' do
      visit '/restaurants'
      expect(page).to have_content 'No restaurants yet'
      expect(page).to have_link 'Add restaurant'
    end
  end

  context 'restaurants have been added' do
    before do
      Restaurant.create(name: 'Ovens')
    end

    scenario 'display restaurants' do
      visit '/restaurants'
      expect(page).to have_content('Ovens')
      expect(page).not_to have_content('No restaurants yet')
    end
  end

  context 'creating restaurants' do
    scenario 'prompts user to fill out a form then displays the new restaurant' do
      visit '/restaurants'
      click_link 'Add restaurant'
      fill_in 'Name', with: 'Ovens'
      click_button 'Create Restaurant'
      expect(page).to have_content 'Ovens'
      expect(current_path).to eq '/restaurants'
    end
  end

  context 'viewing restaurants' do
    let!(:ovens){Restaurant.create(name:'Ovens')}
    scenario 'lets a user view a restaurant' do
      visit '/restaurants'
      click_link 'Ovens'
      expect(page).to have_content 'Ovens'
      expect(current_path).to eq "/restaurants/#{ovens.id}"
    end
  end

  context 'editing restaurants' do
    before{Restaurant.create name: 'Ovens'}
    scenario 'lets a user edit a restaurant' do
      visit '/restaurants'
      click_link 'Edit Ovens'
      fill_in 'Name', with: "Best Aubergine Bakes"
      click_button 'Update Restaurant'
      expect(page).to have_content 'Best Aubergine Bakes'
      expect(current_path).to eq '/restaurants'
    end
  end

  context 'deleting restaurants' do
    before{Restaurant.create name: 'Ovens'}
    scenario 'removes a restaurant when a user clicks a delete link' do
      visit '/restaurants'
      click_link 'Delete Ovens'
      expect(page).to have_content 'Ovens'
      expect(page).to have_content 'Restaurant deleted successfully'
    end
  end

end
