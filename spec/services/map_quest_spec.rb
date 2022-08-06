require 'rails_helper'

RSpec.describe MapQuestService do
    before :each do 
        response = File.read('spec/mocks/location.json')
        data = JSON.parse(response, symbolize_names: true)
        @geocode = data[:results][0][:locations][0][:latLng]
    end

    it 'retrieves location data and parses response into longitude and latitude' do

        expect(@geocode).to be_a Hash

        expect(@geocode[:lng]).to be_a Float

        expect(@geocode[:lat]).to be_a Float
    end
end