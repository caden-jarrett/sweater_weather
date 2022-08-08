class YelpFacade 
    def self.get_location(city, food)
        YelpService.get_info(city, food)
    end
end