require 'rails_helper'

describe Forecast do 
    xit 'creates a forecast object that can have ruby . called on it' do
        @forecast= Forecast.new(ForecastSerializer.format_forecast(forecast_info))
    end
end