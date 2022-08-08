class MapQuestService

    def self.conn 
        Faraday.new(url: 'http://www.mapquestapi.com') do |faraday|
            faraday.params['key'] = ENV['map-api-key']
        end
    end

    def self.find_geocode(location)
        response = conn.get("/geocoding/v1/address?location=#{location}")
        data = JSON.parse(response.body, symbolize_names: true)
        data[:results][0][:locations][0][:latLng]
    end 
end