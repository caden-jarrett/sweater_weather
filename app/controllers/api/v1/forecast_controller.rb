class Api::V1::ForecastController < ApplicationController
    def index
        serialize_weather
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