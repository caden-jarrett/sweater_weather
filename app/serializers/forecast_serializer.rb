class ForecastSerializer 
    def self.format_forecast(forecast_info)
        {
            data: {
                id: nil,
                type: 'forecast',
                attributes: {
                    current_weather: {
                        datetime: Time.at(forecast_info[:current][:dt]),
                        sunrise: Time.at(forecast_info[:current][:sunrise]),
                        sunset: Time.at(forecast_info[:current][:sunset]),
                        temperature: forecast_info[:current][:temp],
                        feels_like: forecast_info[:current][:feels_like],
                        humidity: forecast_info[:current][:humidity],
                        uvi: forecast_info[:current][:uvi],
                        visibility: forecast_info[:current][:visibility],
                        conditions: forecast_info[:current][:weather].first[:description],
                        icon: forecast_info[:current][:weather].first[:icon]
                    },
                    daily_weather: 
                        forecast_info[:daily].map do |dw|
                            {
                                date: Time.at(dw[:dt]).strftime("%F"),
                                sunrise: Time.at(dw[:sunrise]),
                                sunset: Time.at(dw[:sunset]),
                                max_temp: dw[:temp][:max],
                                min_temp: dw[:temp][:min],
                                conditions: dw[:weather].first[:description],
                                icon: dw[:weather].first[:icon]
                            }
                        end.take(5),
                    hourly_weather: 
                        forecast_info[:daily].map do |hw|
                            {
                                time: Time.at(hw[:dt]).strftime("%T"),
                                temperature: hw[:temp],
                                conditions: hw[:weather].first[:description],
                                icon: hw[:weather].first[:icon]
                            }
                        end.take(8)
                }
            }
        }
    end
end