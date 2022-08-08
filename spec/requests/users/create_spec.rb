require 'rails_helper'

describe 'user creation endpoint' do
    describe 'happy path' do
        it 'exposes a users information for creation' do
            login = {
                email: 'test@gmail.com',
                password: 'password123',
                password_confirmation: 'password123'
            }
            post '/api/v1/users', params:login
            
            user1 = User.first

            expect(response.status).to eq 200
            expect(user1).to be_a User
            expect(user1.id).to eq 1
            expect(user1.email).to eq 'test@gmail.com'
            expect(user1.api_key).to be_a String
        end
    end

    describe 'sad path' do 
        it 'returns a 400 error if paswords dont match' do
            login = {
                email: 'test@gmail.com',
                password: 'password123',
                password_confirmation: 'password122'
            }
            post '/api/v1/users', params:login

            response_body = JSON.parse(response.body, symbolize_names: true)

            expect(response.status).to eq 400
            expect(response_body[:error]).to eq "Password confirmation doesn't match Password"
        end

        it 'returns a 400 error if paswords dont match' do
            login = {
                email: '',
                password: 'password123',
                password_confirmation: 'password123'
            }
            post '/api/v1/users', params:login

            response_body = JSON.parse(response.body, symbolize_names: true)

            expect(response.status).to eq 400
            expect(response_body[:error]).to eq "Email can't be blank"
        end

        it 'returns a 400 error if paswords dont match' do
            login = {
                email: '',
                password: '',
                password_confirmation: ''
            }
            post '/api/v1/users', params:login

            response_body = JSON.parse(response.body, symbolize_names: true)

            expect(response.status).to eq 400
            expect(response_body[:error]).to eq "Email can't be blank, Password can't be blank, and Password can't be blank"
        end
    end
end