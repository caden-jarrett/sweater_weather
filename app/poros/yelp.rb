class Yelp
    attr_reader :name, :address, :location
    def initialize(data) 
        @name = data[:businesses].first[:name]
        @address = "#{data[:businesses].first[:location][:display_address].first}, #{data[:businesses].first[:location][:display_address].second}"
        @location = "#{data[:businesses].first[:location][:city]}, #{data[:businesses].first[:location][:state]}"
    end
end