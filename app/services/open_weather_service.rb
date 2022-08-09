class OpenWeatherService

    def self.conn 
        conn = Faraday.new(url: 'http://api.openweathermap.org')
    end
    def self.get_weather(geocode)
        response = conn.get("/data/2.5/onecall") do |f|
            f.params['lat'] = geocode[:lat]
            f.params['lon'] = geocode[:lng]
            f.params['units'] = 'imperial'
            f.params['appid'] = ENV['forecast_key']
        end
        data = JSON.parse(response.body, symbolize_names: true)

        Forecast.new(data)
    end

    def self.get_travel_weather(geocode)
        response = conn.get("/data/2.5/onecall") do |f|
            f.params['lat'] = geocode[:lat]
            f.params['lon'] = geocode[:lng]
            f.params['units'] = 'imperial'
            f.params['appid'] = ENV['forecast_key']
        end
        data = JSON.parse(response.body, symbolize_names: true)
    end
end