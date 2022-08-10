require 'rails_helper'

describe Forecast, :vcr do 
    before :each, :vcr do 
        response = File.read('spec/mocks/forecast.json')
        @data = JSON.parse(response, symbolize_names: true)
    end
    it 'creates a yelp object that can have ruby . called on it', :vcr do
        forecast = Forecast.new(@data)

        expect(forecast.current_weather).to be_a Hash
        expect(forecast.id).to eq nil
        expect(forecast.type).to eq 'forecast'
        expect(forecast.current_weather[:datetime]).to be_a Time
        expect(forecast.current_weather[:sunrise]).to be_a Time
        expect(forecast.current_weather[:temperature]).to be_a Float 
        expect(forecast.current_weather[:conditions]).to be_a String
        expect(forecast.current_weather[:feels_like]).to be_a Float
        expect(forecast.current_weather[:visibility]).to be_a Integer
        expect(forecast.daily_weather).to be_a Array
        expect(forecast.hourly_weather).to be_a Array
    end
end