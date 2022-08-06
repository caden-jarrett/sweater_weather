class OpenWeatherFacade 
    def self.get_forecast(geocode)
        OpenWeatherService.get_weather(geocode)
    end
end