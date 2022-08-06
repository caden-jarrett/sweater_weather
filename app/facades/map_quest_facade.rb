class MapQuestFacade
    def self.get_geocode(location)
        MapQuestService.find_geocode(location)
    end
end