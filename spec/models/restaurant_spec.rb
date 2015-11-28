require 'spec_helper'

describe Restaurant, type: :model do
    it {is_expected.to have_many :reviews}

    it 'is not valid with a name of less than three characters' do
      restaurant = Restaurant.new(name: 'Ov')
      expect(restaurant).to have(1).error_on(:name)
      expect(restaurant).not_to be_valid
    end

    it 'is not valid unless it has a unique name' do
      Restaurant.create(name: 'Fergburger')
      restaurant = Restaurant.new(name: 'Fergburger')
      expect(restaurant).to have(1).error_on(:name)
    end

  describe '#average_rating' do
    context 'no reviews' do
      it 'returns "N/A" when there are no reviews' do
        restaurant = Restaurant.create(name: 'The Ivy')
        expect(restaurant.average_rating).to eq 'N/A'
      end
    end
    context 'has 1 review' do
      it 'returns that rating' do
        restaurant = Restaurant.create(name: 'The Ivy')
        restaurant.reviews.create(rating: 4)
        expect(restaurant.average_rating).to eq 4
      end
    end
    context 'has multiple reviews' do
      it 'returns the average rating' do
        restaurant = Restaurant.create(name: 'Ivy')
        restaurant.reviews.create(rating: 1)
        restaurant.reviews.create(rating: 5)
        expect(restaurant.average_rating).to eq 3
      end
    end

  end

end
