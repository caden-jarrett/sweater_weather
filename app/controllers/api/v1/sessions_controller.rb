class Api::V1::SessionsController < ApplicationController
    def create 
        user = User.find_by(email: params[:email])
        if user == nil
            render json: { error: 'Incorrect login information' }, status:400
        elsif user&.authenticate(params[:password]) != false
            session[:id] = user.id 
            render json: UserSerializer.create_user(user)
        else
            render json: { error: 'Incorrect login information' }, status:400
        end
    end
end