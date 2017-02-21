require 'rails_helper'


feature 'restaurants' do

  context 'Checking the backend' do
    before do
      Restaurant.create(name: 'KFC')
    end
    scenario 'should have added a restaurant to the db' do
      visit '/restaurants'
      expect(page).to have_content 'KFC'
      expect(page).not_to have_content 'No restaurants yet'
    end
  end

  context 'no restaurants should have been added' do
    scenario 'should display a prompt to add a restaurant' do
      visit '/restaurants'
      expect(page).to have_content 'No restaurants yet'
      expect(page).to have_link 'Add a restaurant'
    end
  end

  context 'using the add a restaurant button' do
    scenario 'should be able to add a restaurant on the main page' do
      visit '/restaurants'
      click_link 'Add a restaurant'
      fill_in 'Name', with: 'KFC'
      click_button 'Create Restaurant'
      expect(page).to have_content 'KFC'
    end
  end

end
