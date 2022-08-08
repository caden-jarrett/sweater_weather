class Api::V1::SessionsController < ApplicationController
    def create 
        user = User.find_by(email: params[:email])
        if user&.authenticate(params[:password]) != nil
            session[:id] = user.id 
            render json: UserSerializer.create_user(user)
        else
            render json: { error: 'Incorrect login information' }, status:400
        end
    end
end