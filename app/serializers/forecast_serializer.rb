class ForecastSerializer 
    def self.format_forecast(forecast_info)
        {
            data: {
                id: nil,
                type: 'forecast',
                attributes: {
                    current_weather: {
                        datetime: Time.at(forecast_info.current_weather[:datetime]),
                        sunrise: Time.at(forecast_info.current_weather[:sunrise]),
                        sunset: Time.at(forecast_info.current_weather[:sunset]),
                        temperature: forecast_info.current_weather[:temperature],
                        feels_like: forecast_info.current_weather[:feels_like],
                        humidity: forecast_info.current_weather[:humidity],
                        uvi: forecast_info.current_weather[:uvi],
                        visibility: forecast_info.current_weather[:visibility],
                        conditions: forecast_info.current_weather[:conditions],
                        icon: forecast_info.current_weather[:icon]
                    },
                    daily_weather: 
                        forecast_info.daily_weather.map do |dw|
                            {
                                date: (dw[:date]),
                                sunrise: Time.at(dw[:sunrise]),
                                sunset: Time.at(dw[:sunset]),
                                max_temp: dw[:max_temp],
                                min_temp: dw[:min_temp],
                                conditions: dw[:conditions],
                                icon: dw[:icon]
                            }
                        end.take(5),
                    hourly_weather: 
                        forecast_info.hourly_weather.map do |hw|
                            {
                                time: (hw[:time]),
                                temperature: hw[:temperature],
                                conditions: hw[:conditions],
                                icon: hw[:icon]
                            }
                        end.take(8)
                }
            }
        }
    end
end