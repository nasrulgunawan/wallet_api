require "latest_stock_price/client"

module LatestStockPrice
  class << self
    def configure
      yield configuration
    end

    def configuration
      @configuration ||= Configuration.new
    end

    def client
      @client ||= Client.new(configuration.api_key)
    end

    def price(stock_symbol)
      client.price(stock_symbol)
    end

    def prices(stock_symbols)
      client.prices(stock_symbols)
    end

    def price_all
      client.price_all
    end
  end

  class Configuration
    attr_accessor :api_key

    def initialize
      @api_key = nil
    end
  end
end
