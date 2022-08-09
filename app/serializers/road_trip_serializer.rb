class RoadTripSerializer 
    def self.format(travel, weather_at_eta)
        {
        data: {
                id: nil,
                type: 'roadtrip',
                attributes: {
                    start_city: travel.origin,
                    end_city: travel.destination,
                    travel_time: travel.duration,
                    weather_at_eta: {
                        temperature: weather_at_eta.temperature,
                        conditions: weather_at_eta.conditions
                    }
                }
            }
        }
    end
end