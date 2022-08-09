class Api::V1::ForecastController < ApplicationController
    def index
        if params[:location]
            serialize_weather
        else 
            render json: {error: 'What are you looking for?'}, status: 400
        end   
    end


    private

    def geocode
        MapQuestFacade.get_geocode(params[:location])
    end

    def forecast_info
        OpenWeatherFacade.get_forecast(geocode)
    end

    def serialize_weather
        render json: ForecastSerializer.format_forecast(forecast_info)
    end
end