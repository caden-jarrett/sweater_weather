class TravelInfo
    attr_reader :origin, :destination, :duration 

    def initialize(data, origin, destination)
        route = data[:route][:formattedTime].split(':') if data[:route][:formattedTime] != nil
        @origin = origin
        @destination = destination
        if route == nil
            @duration = 'impossibru'
        else
            @duration = "#{route[0].to_i / 24} day(s), #{route[0].to_i % 24} hour(s), #{data[:route][:formattedTime][3..4]} minutes"
        end
    end
end