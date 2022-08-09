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
        {
            datetime: Time.at(data[:current][:dt]),
            sunrise: Time.at(data[:current][:sunrise]),
            sunset: Time.at(data[:current][:sunset]),
            temperature: data[:current][:temp],
            feels_like: data[:current][:feels_like],
            humidity: data[:current][:humidity],
            uvi: data[:current][:uvi],
            visibility: data[:current][:visibility],
            conditions: data[:current][:weather].first[:description],
            icon: data[:current][:weather].first[:icon]
        }
    end

    def weather_5day(data)
        data[:daily].map do |dw|
            {
                date: Time.at(dw[:dt]).strftime("%F"),
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
                time: Time.at(hw[:dt]).strftime("%T"),
                temperature: hw[:temp],
                conditions: hw[:weather].first[:description],
                icon: hw[:weather].first[:icon]
            }
        end.take(8)
    end
end