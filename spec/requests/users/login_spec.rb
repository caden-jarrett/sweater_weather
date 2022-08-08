require 'rails_helper'

describe 'user session endpoint' do
    describe 'happy path' do
        it 'exposes a users information for log in' do
            User.create(email: 'test@gmail.com', password: 'password123', password_confirmation: 'password123', api_key: 'AASV34gasda')
            login = {
                email: 'test@gmail.com',
                password: 'password123'
            }
            post '/api/v1/sessions', params:login
            
            user1 = User.first

            expect(response.status).to eq 200
            expect(user1).to be_a User
            expect(user1.id).to eq 1
            expect(user1.email).to eq 'test@gmail.com'
            expect(user1.api_key).to be_a String
        end
    end

    describe 'sad path' do 
        it 'returns a 400 error if passwords dont match' do
            login = {
                email: 'test@gmail.com',
                password: 'password12'
            }
            post '/api/v1/sessions', params:login

            response_body = JSON.parse(response.body, symbolize_names: true)

            expect(response.status).to eq 400
            expect(response_body[:error]).to eq 'Incorrect login information'
        end

        it 'returns a 400 error if a email isnt entered' do
            login = {
                email: '',
                password: 'password123'
            }
            post '/api/v1/sessions', params:login

            response_body = JSON.parse(response.body, symbolize_names: true)

            expect(response.status).to eq 400
            expect(response_body[:error]).to eq 'Incorrect login information'
        end

        it 'returns a 400 error if nothing is entered' do
            login = {
                email: '',
                password: ''
            }
            post '/api/v1/sessions', params:login

            response_body = JSON.parse(response.body, symbolize_names: true)

            expect(response.status).to eq 400
            expect(response_body[:error]).to eq 'Incorrect login information'
        end
    end
end