require 'rails_helper'

describe 'Munchies API' do
    describe 'happy path' do
        # before :each do 
        #     response = File.read('/mocks/forecast.json')
        #     @data = JSON.parse(response.body, symbolize_names: true)
        # end

        it 'send a current, daily, and hourly weather report' do

            get '/api/v1/munchies?location=denver,co&food=chinese'
            expect(response.status).to eq(200)
            
            destination = JSON.parse(response.body, symbolize_names: true)

            expect(destination[:data][:id]).to eq(nil)
            expect(destination[:data][:type]).to eq("munchie")
            expect(destination[:data][:attributes]).to be_a(Hash)
            expect(destination[:data][:attributes][:destination_city]).to eq('Denver, CO')
            expect(destination[:data][:attributes][:forecast]).to be_a(Hash)
            expect(destination[:data][:attributes][:forecast][:summary]).to be_a(String)
            expect(destination[:data][:attributes][:forecast][:temperature]).to be_a(String)
            expect(destination[:data][:attributes][:restaurant]).to be_a(Hash)
            expect(destination[:data][:attributes][:restaurant][:name]).to be_a(String)
            expect(destination[:data][:attributes][:restaurant][:address]).to be_a(String)
        end
    end
end