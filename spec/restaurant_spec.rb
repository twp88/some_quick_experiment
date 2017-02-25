require 'rails_helper'

describe Restaurant, type: :model do
  it 'shouldnt allow a name of a restaurant with less than three letters' do
    restaurant = Restaurant.new(name: 'kf')
    expect(restaurant).to have(1).error_on(:name)
    expect(restaurant).not_to be_valid

  end
end
