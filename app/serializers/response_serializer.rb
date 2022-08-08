class ResponseSerializer 
    def self.get_all_info(location_food, weather, city)
        {
            data: {
                id: nil,
                type: 'munchie',
                attributes: {
                    destination_city: "#{location_food.location}",
                    forecast: {
                        summary: weather[:current][:weather].first[:description],
                        temperature: weather[:current][:temp].to_s
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