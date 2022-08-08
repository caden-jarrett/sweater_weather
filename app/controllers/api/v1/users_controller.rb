class Api::V1::UsersController < ApplicationController
    def create 
        user = User.new(user_params)
        user[:api_key] = SecureRandom.hex
        if user.save 
            render json: UserSerializer.create_user(user)
        else
            render json: {error: user.errors.full_messages.to_sentence}, status:400
        end
    end

    private 

    def user_params
        params.permit(:email, :password, :password_confirmation)
    end
end