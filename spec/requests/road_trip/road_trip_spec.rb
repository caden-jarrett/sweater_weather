require 'rails_helper'

describe 'Road Trip Route', :vcr do
    describe 'happy path', :vcr do
        it 'send a road trip report with road trip info', :vcr do
            user1 = User.create(email: 'test@gmail.com', password: 'password123', password_confirmation: 'password123', api_key: 'e19544b7ea8d785acdabf9b63faae8d7')
            params = {
            "origin": "Denver,CO",
            "destination": "Pueblo,CO",
            "api_key": user1.api_key
            }
            post '/api/v1/road_trip', params:params

            expect(response.status).to eq(200)

            road_trip = JSON.parse(response.body, symbolize_names: true)

            expect(road_trip[:data][:type]).to eq 'roadtrip'
            expect(road_trip[:data]).to have_key :id
            expect(road_trip[:data]).to have_key :type
            expect(road_trip[:data]).to have_key :attributes
            expect(road_trip[:data][:id]).to eq nil
            expect(road_trip[:data][:type]).to be_a String
            expect(road_trip[:data][:attributes]).to be_a Hash
            expect(road_trip[:data][:attributes][:start_city]).to eq 'Denver,CO'
            expect(road_trip[:data][:attributes][:end_city]).to eq 'Pueblo,CO'
            expect(road_trip[:data][:attributes][:travel_time]).to eq "0 day(s), 1 hour(s), 45 minutes"
        end

        it 'send a road trip report with road trip info from NY to Panama', :vcr do
            user1 = User.create(email: 'test@gmail.com', password: 'password123', password_confirmation: 'password123', api_key: 'e19544b7ea8d785acdabf9b63faae8d7')
            params = {
            "origin": "New York,NY",
            "destination": "Panama City,Panama",
            "api_key": user1.api_key
            }
            post '/api/v1/road_trip', params:params

            expect(response.status).to eq(200)

            road_trip = JSON.parse(response.body, symbolize_names: true)

            expect(road_trip[:data][:type]).to eq 'roadtrip'
            expect(road_trip[:data]).to have_key :id
            expect(road_trip[:data]).to have_key :type
            expect(road_trip[:data]).to have_key :attributes
            expect(road_trip[:data][:id]).to eq nil
            expect(road_trip[:data][:type]).to be_a String
            expect(road_trip[:data][:attributes]).to be_a Hash
            expect(road_trip[:data][:attributes][:start_city]).to eq "New York,NY"
            expect(road_trip[:data][:attributes][:end_city]).to eq "Panama City,Panama"
            expect(road_trip[:data][:attributes][:travel_time]).to eq "3 day(s), 8 hour(s), 04 minutes"
        end

        it 'send a road trip report with road trip info for NY to London' do
            user1 = User.create(email: 'test@gmail.com', password: 'password123', password_confirmation: 'password123', api_key: 'e19544b7ea8d785acdabf9b63faae8d7')
            params = {
            "origin": "New York,NY",
            "destination": "London,UK",
            "api_key": user1.api_key
            }
            post '/api/v1/road_trip', params:params

            expect(response.status).to eq(200)

            road_trip = JSON.parse(response.body, symbolize_names: true)

            expect(road_trip[:data][:type]).to eq 'roadtrip'
            expect(road_trip[:data]).to have_key :id
            expect(road_trip[:data]).to have_key :type
            expect(road_trip[:data]).to have_key :attributes
            expect(road_trip[:data][:id]).to eq nil
            expect(road_trip[:data][:type]).to be_a String
            expect(road_trip[:data][:attributes]).to be_a Hash
            expect(road_trip[:data][:attributes][:start_city]).to eq "New York,NY"
            expect(road_trip[:data][:attributes][:end_city]).to eq "London,UK"
            expect(road_trip[:data][:attributes][:travel_time]).to eq "impossibru"
            expect(road_trip[:data][:attributes][:weather_at_eta][:temperature]).to eq 'Who Knows'
            expect(road_trip[:data][:attributes][:weather_at_eta][:conditions]).to eq 'Who Knows'
        end

        it 'send a road trip report with road trip info from Russia to South Africa', :vcr do
            user1 = User.create(email: 'test@gmail.com', password: 'password123', password_confirmation: 'password123', api_key: 'e19544b7ea8d785acdabf9b63faae8d7')
            params = {
            "origin": "Khasan, Russia",
            "destination": "Cape Town,South Africa",
            "api_key": user1.api_key
            }
            post '/api/v1/road_trip', params:params

            expect(response.status).to eq(200)

            road_trip = JSON.parse(response.body, symbolize_names: true)

            expect(road_trip[:data][:type]).to eq 'roadtrip'
            expect(road_trip[:data]).to have_key :id
            expect(road_trip[:data]).to have_key :type
            expect(road_trip[:data]).to have_key :attributes
            expect(road_trip[:data][:id]).to eq nil
            expect(road_trip[:data][:type]).to be_a String
            expect(road_trip[:data][:attributes]).to be_a Hash
            expect(road_trip[:data][:attributes][:start_city]).to eq "Khasan, Russia"
            expect(road_trip[:data][:attributes][:end_city]).to eq "Cape Town,South Africa"
            expect(road_trip[:data][:attributes][:travel_time]).to eq "9 day(s), 21 hour(s), :0 minutes"
            expect(road_trip[:data][:attributes][:weather_at_eta][:temperature]).to eq "Too far away to determine weather"
            expect(road_trip[:data][:attributes][:weather_at_eta][:conditions]).to eq "Too far away to determine weather"
        end
    end

    describe 'sad path', :vcr do
        it 'sends a unknow api key error if the api key doesnt match a users', :vcr do
            user1 = User.create(email: 'test@gmail.com', password: 'password123', password_confirmation: 'password123', api_key: 'e19544b7ea8d785acdabf9b63faae8d7')
            params = {
            "origin": "Khasan, Russia",
            "destination": "Cape Town,South Africa",
            "api_key": 'nottheapikey'
            }
            post '/api/v1/road_trip', params:params

            expect(response.status).to eq(400)
            error = JSON.parse(response.body, symbolize_names: true)
            expect(error[:error]).to eq('Unknown API key')
        end
    end
end