require "net/http"
require "json"

# Notes
# - endpoint /price and /prices is does not exist, all request will be sent to /any

module LatestStockPrice
  class Client
    BASE_URL = "https://latest-stock-price.p.rapidapi.com"
    RAPID_API_HOST = "latest-stock-price.p.rapidapi.com"

    def initialize(api_key)
      @api_key = api_key
    end

    def price(identifier)
      fetch_stock_data("/any", Identifier: identifier)
    end

    def prices(stock_symbols)
      fetch_stock_data("/any", Identifier: stock_symbols.join(","))
    end

    def price_all
      fetch_stock_data("/any")
    end

    private

    def fetch_stock_data(endpoint, params = {})
      uri = build_uri(endpoint, params)
      response = make_api_request(uri)
      parse_response(response)
    rescue StandardError => e
      handle_error(e)
    end

    def build_uri(endpoint, params)
      uri = URI("#{BASE_URL}#{endpoint}")
      uri.query = URI.encode_www_form(params) unless params.empty?
      uri
    end

    def make_api_request(uri)
      Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
        request = Net::HTTP::Get.new(uri)
        request["X-RapidAPI-Key"] = @api_key
        request["X-RapidAPI-Host"] = RAPID_API_HOST
        http.request(request)
      end
    end

    def parse_response(response)
      JSON.parse(response.body)
    end

    def handle_error(error)
      raise "Failed to fetch stock prices: #{error.message}"
    end
  end
end
