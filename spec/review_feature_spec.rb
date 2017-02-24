require 'rails_helper'

feature 'reviews' do

  context 'checking the review function' do

    let!(:kfc){ Restaurant.create(name: 'KFC', description: 'Shitty Licky Chicken') }

    scenario 'you should be able to leave a review for a restaurant' do
      visit '/restaurants'
      click_link 'Review this restaurant'
      fill_in 'Thoughts', with: 'Pretty shitty chicken'
      select '3', from: 'Rating'
      click_button 'Leave Review'
      click_link 'KFC'

      expect(page).to have_content 'Pretty shitty chicken'
    end
  end

end
