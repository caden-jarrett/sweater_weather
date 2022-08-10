require 'rails_helper'

describe Yelp, :vcr do 
    it 'creates a yelp object that can have ruby . called on it', :vcr do
        @yelp= Yelp.new(YelpService.get_info('denver,co', 'chinese'))
        
        expect(@yelp.name).to eq("Fortune Wok to Table")
        expect(@yelp.address).to eq("2817 E 3rd Ave, Denver, CO 80206")
        expect(@yelp.location).to eq("Denver, CO")
    end
end