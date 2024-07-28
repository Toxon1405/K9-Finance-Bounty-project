
module API

    require 'uri'
    require 'net/http'
    require 'psych'

    def self.get_request(uri)
        uri = URI(uri)
        response = Net::HTTP.get_response uri, {
            'accept' => 'application/json'
        }
        raise 'Failed to query API.' unless response.is_a? Net::HTTPSuccess
        result = Psych.safe_load response.body
        raise 'Failed to parse.' unless result.is_a? Hash
        return result
    end

    def self.get_token_info(address)
        return get_request("https://www.shibariumscan.io/api/v2/tokens/#{address}")
    end

    def self.get_token_counters(address)
        return get_request("https://www.shibariumscan.io/api/v2/tokens/#{address}/counters")
    end

end
