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
      fill_in 'Description', with: 'Shitty Licky Chicken'
      click_button 'Create Restaurant'
      expect(page).to have_content 'KFC'
    end
  end

  context 'using the back button' do
    scenario 'clicking the back button should take you back' do
      visit '/restaurants'
      click_link 'Add a restaurant'
      click_link 'Back'
      expect(current_path).to eq '/restaurants'
    end
  end

  context 'clicking the link to the restaurant' do

    let!(:kfc){ Restaurant.create(name: 'KFC', description: 'Shitty Licky Chicken') }

    scenario 'should take you to the specific restaurant page' do
      visit '/restaurants'
      click_link 'KFC'
      expect(page).to have_content 'KFC'
      expect(page).to have_content 'Shitty Licky Chicken'
      expect(current_path).to eq "/restaurants/#{kfc.id}"
    end

    scenario 'check back button' do
      visit '/restaurants'
      click_link 'KFC'
      click_link 'Back'
      expect(current_path).to eq '/restaurants'
    end
  end

  context 'checking the update function' do

    let!(:kfc){ Restaurant.create(name: 'KFC', description: 'Shitty Licky Chicken') }

    scenario 'should be able to go back and alter data' do
      visit '/restaurants'
      click_link 'KFC'
      click_link 'Edit KFC'
      fill_in 'Name', with: 'Boom'
      fill_in 'Description', with: 'Delish'
      click_button 'Update Restaurant'
      expect(current_path).to eq '/restaurants'
      expect(page).to have_content 'Boom'
    end
  end

  context 'checking the delete/destroy method works' do
     before { Restaurant.create name: 'KFC', description: 'Deep fried goodness' }
    scenario 'should be able to delete destory a restaurant' do
      visit '/restaurants'
      click_link 'KFC'
      click_link 'Delete KFC'
      expect(current_path).to eq '/restaurants'
      expect(page).not_to have_content 'KFC'
      expect(page).to have_content 'No restaurants yet'
    end
  end

end
