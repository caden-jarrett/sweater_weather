class MapQuestFacade
    def self.get_geocode(location)
        MapQuestService.find_geocode(location)
    end

    def self.get_travel_info(origin, destination)
        MapQuestService.travel_info(origin, destination)
    end
end