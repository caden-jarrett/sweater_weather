class OpenWeatherFacade 
    def self.get_forecast(geocode)
        OpenWeatherService.get_weather(geocode)
    end

    def self.get_weather(geocode)
        OpenWeatherService.get_travel_weather(geocode)
    end
end