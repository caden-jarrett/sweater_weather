class Api::V1::MunchiesController < ApplicationController
    def index 
        get_all_info(location_food, weather)
    end

    private 
    def city
        params[:location]
    end

    def food 
        params[:food]
    end
    
    def geocode
        MapQuestFacade.get_geocode(params[:location])
    end

    def weather
        OpenWeatherFacade.get_forecast(geocode)
    end


    def location_food 
        YelpFacade.get_location(city, food)
    end

    def get_all_info(location_food, weather)
        render json: ResponseSerializer.get_all_info(location_food, weather)
    end
end