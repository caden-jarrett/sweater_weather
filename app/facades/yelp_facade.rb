class YelpFacade 
    def self.get_location(city, food)
        Yelp.new(YelpService.get_info(city, food))
    end
end