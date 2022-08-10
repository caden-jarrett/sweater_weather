require 'rails_helper'

RSpec.describe MapQuestService, :vcr do
    before :each, :vcr do 
        response = File.read('spec/mocks/location.json')
        data = JSON.parse(response, symbolize_names: true)
        @geocode = MapQuestService.find_geocode('Pueblo, CO')
    end

    it 'retrieves location data and parses response into longitude and latitude', :vcr do

        expect(@geocode).to be_a Hash

        expect(@geocode[:lng]).to be_a Float

        expect(@geocode[:lat]).to be_a Float
    end
end