require 'rails_helper'

describe 'Munchies API' do
    describe 'happy path' do
        # before :each do 
        #     response = File.read('/mocks/forecast.json')
        #     @data = JSON.parse(response.body, symbolize_names: true)
        # end

        it 'send a current, daily, and hourly weather report' do

            get '/api/v1/munchies?location=denver,co&food=chinese'
            binding.pry
            expect(response.status).to eq(200)

            destination = JSON.parse(response.body, symbolize_names: true)

            expect(destination[:id]).to eq(nil)
            expect(destination[:type]).to eq("munchie")
            expect(destination[:attributes]).to be_a(Hash)
            expect(destination[:attributes][:destination_city]).to be('denver,co')
            expect(destination[:attributes][:forecast]).to be_a(Hash)
            expect(destination[:attributes][:forecast][:summary]).to be_a(String)
            expect(destination[:attributes][:forecast][:temperature]).to be_a(String)
            expect(destination[:attributes][:restaurant]).to be_a(Hash)
            expect(destination[:attributes][:restaurant][:name]).to be_a(String)
            expect(destination[:attributes][:restaurant][:address]).to be_a(String)
        end
    end
end