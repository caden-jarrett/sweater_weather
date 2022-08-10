class Api::V1::RoadTripController < ApplicationController
    def show 
        get_road_trip(travel, weather_at_eta) 
    end

    private 

    def geocode
        MapQuestFacade.get_geocode(params[:destination])
    end

    def forecast_info
        OpenWeatherFacade.get_weather(geocode)
    end

    def weather_at_eta
        user = User.find_by(api_key: params[:api_key])
        if user != nil
            weather = forecast_info
            duration = travel.duration
            if duration != nil
                @eta = duration.split(':')[0..1][0][0].to_i
            else
                duration = 'impossibru'
            end
            if duration == 'impossibru'
                @travel_weather = 'Who Knows'
            elsif travel.duration.first.to_i < 2
                weather = weather[:hourly][@eta]
                @travel_weather = TravelWeather.new(weather)
            elsif travel.duration.first.to_i < 8
                weather = weather[:daily][@eta/24]
                @travel_weather = TravelWeather.new(weather)
            elsif travel.duration.first.to_i > 8
                response = 'Too far away to determine weather'
                @travel_weather = TravelWeather.new(response)
            end
        else
            @travel_weather = nil
        end
        return @travel_weather
    end

    def travel
        MapQuestFacade.get_travel_info(params[:origin], params[:destination])
    end

    def get_road_trip(travel, weather_at_eta)
        if weather_at_eta == nil
            render json: { error: 'Unknown API key'}, status:400
        elsif weather_at_eta.temperature.class == Hash 
            render json: RoadTripSerializer.daily_format(travel, weather_at_eta)
        elsif weather_at_eta == 'Who Knows'
            render json: ImpossibleRoadTripSerializer.format(travel, weather_at_eta)
        else
            render json: RoadTripSerializer.format(travel, weather_at_eta)
        end
    end
end