class TravelWeather 
    attr_reader :temperature, :conditions 

    def initialize(data)
        if data != 'Too far away to determine weather'
            @temperature = data[:temp]
            @conditions = data[:weather].first[:description]
        else
            @temperature = data
            @conditions = data
        end
    end
end