class Forecast 
    attr_reader :id, :type, :current_weather, :hourly_weather, :daily_weather

    def initialize(data)
        @id = nil 
        @type = 'forecast'
        @current_weather = weather_atm(data)
        @daily_weather = weather_5day(data)
        @hourly_weather = hours_8(data)
    end

    private 

    def weather_atm(data)
        current = data[:current]
        {
            datetime: Time.at(current[:dt]),
            sunrise: Time.at(current[:sunrise]),
            sunset: Time.at(current[:sunset]),
            temperature: current[:temp],
            feels_like: current[:feels_like],
            humidity: current[:humidity],
            uvi: current[:uvi],
            visibility: current[:visibility],
            conditions: current[:weather].first[:description],
            icon: current[:weather].first[:icon]
        }
    end

    def weather_5day(data)
        data[:daily].map do |dw|
            {
                date: Time.at(dw[:dt]).strftime("%Y-%m-%d"),
                sunrise: Time.at(dw[:sunrise]),
                sunset: Time.at(dw[:sunset]),
                max_temp: dw[:temp][:max],
                min_temp: dw[:temp][:min],
                conditions: dw[:weather].first[:description],
                icon: dw[:weather].first[:icon]
            }
        end.take(5)
    end

    def hours_8(data)
        data[:hourly].map do |hw|
            {
                time: Time.at(hw[:dt]).strftime("%I:%M %p"),
                temperature: hw[:temp],
                conditions: hw[:weather].first[:description],
                icon: hw[:weather].first[:icon]
            }
        end.take(8)
    end
end