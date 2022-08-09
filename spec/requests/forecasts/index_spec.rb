require 'rails_helper'

describe 'Forecast API' do
    describe 'happy path' do
        it 'send a current, daily, and hourly weather report' do

            get '/api/v1/forecast?location=denver,co'

            expect(response.status).to eq(200)

            forecast = JSON.parse(response.body, symbolize_names: true)

            expect(forecast[:id]).to eq(nil)
            @forecast = forecast[:data][:attributes]
            # Forecast
            expect(@forecast).to be_a(Hash)
            expect(@forecast).to have_key :current_weather
            expect(@forecast).to have_key :hourly_weather
            expect(@forecast).to have_key :daily_weather
            expect(@forecast[:current_weather]).to be_a Hash
            expect(@forecast[:daily_weather]).to be_a Array
            expect(@forecast[:hourly_weather]).to be_a Array

            # Current Weather 
            expect(@forecast[:current_weather]).to be_a Hash
            expect(@forecast[:current_weather]).to have_key :datetime
            expect(@forecast[:current_weather]).to have_key :sunrise
            expect(@forecast[:current_weather]).to have_key :sunset 
            expect(@forecast[:current_weather]).to have_key :temperature 
            expect(@forecast[:current_weather]).to have_key :feels_like 
            expect(@forecast[:current_weather]).to have_key :humidity
            expect(@forecast[:current_weather]).to have_key :uvi 
            expect(@forecast[:current_weather]).to have_key :visibility 
            expect(@forecast[:current_weather]).to have_key :conditions 
            expect(@forecast[:current_weather]).to have_key :icon
            expect(@forecast[:current_weather][:datetime]).to be_a String
            expect(@forecast[:current_weather][:sunrise]).to be_a String
            expect(@forecast[:current_weather][:sunset]).to be_a String
            expect(@forecast[:current_weather][:temperature]).to be_a Float 
            expect(@forecast[:current_weather][:feels_like]).to be_a Float
            expect(@forecast[:current_weather][:humidity]).to be_a Integer
            expect(@forecast[:current_weather][:uvi]).to be_a Float
            expect(@forecast[:current_weather][:visibility]).to be_a Integer
            expect(@forecast[:current_weather][:conditions]).to be_a String
            expect(@forecast[:current_weather][:icon]).to be_a String

            # to not have 
            expect(@forecast[:current_weather]).to_not have_key :pressure
            expect(@forecast[:current_weather]).to_not have_key :dew_point
            expect(@forecast[:current_weather]).to_not have_key :clouds
            expect(@forecast[:current_weather]).to_not have_key :wind_speed 
            expect(@forecast[:current_weather]).to_not have_key :wind_gust
            

            # Daily Weather
            expect(@forecast[:hourly_weather].count).to eq 8
            @forecast[:hourly_weather].each do |hw|
                expect(hw).to have_key :time
                expect(hw).to have_key :temperature
                expect(hw).to have_key :conditions
                expect(hw).to have_key :icon
                expect(hw[:time]).to be_a String
                expect(hw[:temperature]).to be_a Float
                expect(hw[:conditions]).to be_a String
                expect(hw[:icon]).to be_a String

                # not to have
                expect(hw).to_not have_key :feels_like
                expect(hw).to_not have_key :pressure
                expect(hw).to_not have_key :dew_point
                expect(hw).to_not have_key :clouds
                expect(hw).to_not have_key :visibility
                expect(hw).to_not have_key :wind_speed
                expect(hw).to_not have_key :wind_deg
                expect(hw).to_not have_key :wind_gust
            end

            # Hourly Weather
            expect(@forecast[:daily_weather].count).to eq 5
            @forecast[:daily_weather].each do |dw|
                expect(dw).to have_key :date
                expect(dw).to have_key :sunrise
                expect(dw).to have_key :sunset
                expect(dw).to have_key :max_temp
                expect(dw).to have_key :min_temp
                expect(dw).to have_key :conditions
                expect(dw).to have_key :icon

                # not to have
                expect(dw).to_not have_key :moonrise
                expect(dw).to_not have_key :moonset
                expect(dw).to_not have_key :moon_phase
                expect(dw).to_not have_key :feels_like
                expect(dw).to_not have_key :pressure
                expect(dw).to_not have_key :dew_point
                expect(dw).to_not have_key :clouds
                expect(dw).to_not have_key :visibility
                expect(dw).to_not have_key :wind_speed
                expect(dw).to_not have_key :wind_deg
                expect(dw).to_not have_key :wind_gust
            end
        end
    end

    describe 'sad path' do 
        it 'returns a 400 error when no query is added' do
            get '/api/v1/forecast' 

            expect(response.status).to eq(400)
            error = JSON.parse(response.body, symbolize_names: true)
            expect(error[:error]).to eq('What are you looking for?')
        end 
    end

end