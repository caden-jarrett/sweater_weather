class ResponseSerializer 
    def self.get_all_info(location_food, weather, city)
        {
            data: {
                id: nil,
                type: 'munchie',
                attributes: {
                    destination_city: "#{location_food[:businesses].first[:location][:city]}, #{location_food[:businesses].first[:location][:state]}",
                    forecast: {
                        summary: weather[:current][:weather].first[:description],
                        temperature: weather[:current][:temp].to_s
                    },
                    restaurant: {
                        name: location_food[:businesses].first[:name],
                        address: "#{location_food[:businesses].first[:location][:display_address].first}, #{location_food[:businesses].first[:location][:display_address].second}"
                    }
                    }
                }
            }
    end
end