class Forecast 
    attr_reader :id, :type, :current_weather, :hourly_weather, :daily_weather

    def initialize(data)
        @id = data[:id]
        @type = data.first.second[:type]
        @current_weather = data.first.second[:attributes][:current_weather]
        @hourly_weather = data.first.second[:attributes][:hourly_weather]
        @daily_weather = data.first.second[:attributes][:daily_weather]
    end
end