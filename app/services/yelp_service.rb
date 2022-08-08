class YelpService

    def self.conn 
        conn = Faraday.new(url: 'https://api.yelp.com') do |f|
            f.headers["Authorization"] = ENV['yelp_key']
        end
    end

    def self.get_info(city, food)
        response = conn.get("/v3/businesses/search") do |f|
            f.params['location'] = city
            f.params['categories'] = food
        end
        data = JSON.parse(response.body, symbolize_names: true)
    end
end