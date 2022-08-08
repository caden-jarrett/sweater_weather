require 'rails_helper'

RSpec.describe YelpService do
    before :each do 
        response = File.read('spec/mocks/yelp.json')
        @data = JSON.parse(response, symbolize_names: true)
    end

    it 'retrieves location and weather data and parses response' do

        expect(@data).to be_a Hash
        expect(@data[:businesses]).to be_a Array

        expect(@data[:businesses].first).to be_a Hash

    end
end