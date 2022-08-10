require 'rails_helper'

describe YelpFacade, :vcr do
    it 'returns a hash of restaurant information', :vcr do
        response = YelpFacade.get_location('New York, NY', 'chinese')
        expect(response).to_not be_a Array
        expect(response).to be_a Yelp
        expect(response.address).to eq("46 Bowery St, New York, NY 10013")
        expect(response.location).to eq("New York, NY")
        expect(response.name).to eq("Joe's Shanghai")
    end
end