class ResponseSerializer 
    def self.get_all_info(location_food, weather)
        {
            data: {
                id: nil,
                type: 'munchie',
                attributes: {
                    destination_city: "#{location_food.location}",
                    forecast: {
                        summary: weather.current_weather[:conditions],
                        temperature: weather.current_weather[:temperature]
                    },
                    restaurant: {
                        name: location_food.name,
                        address: "#{location_food.address}"
                    }
                }
            }
        }
    end
end