require 'rails_helper'

describe 'Forecast API' do
    describe 'happy path' do
        # before :each do 
        #     response = File.read('/mocks/forecast.json')
        #     @data = JSON.parse(response.body, symbolize_names: true)
        # end

        it 'send a current, daily, and hourly weather report' do

            get '/api/v1/forecast?location=denver,co'

            expect(response.status).to eq(200)

            forecast = JSON.parse(response.body, symbolize_names: true)

            expect(forecast[:id]).to eq(nil)

            expect(forecast).to be_a(Hash)
            expect(forecast[:current_weather]).to be_a(Hash)
            expect(forecast[:daily_weather]).to be_a(Array)
            expect(forecast[:hourly_weather]).to be_a(Array)
            expect(forecast[:daily_weather].count).to be 5
            expect(forecast[:hourly_weather].count).to be 8
        end
    end
end