# README



## LatestStockPrice Usage

1. Configure the API Key:
   ```ruby
   LatestStockPrice.configure do |config|
     config.api_key = 'YOUR_API_KEY'
   end
   ```

2. Get a single stock price:
   ```ruby
   price = LatestStockPrice.price('NIFTY 50')
   ```

3. Get prices for multiple stocks:
   ```ruby
   prices = LatestStockPrice.prices(['NIFTY 50', 'BAJFINANCEEQN'])
   ```

4. Get prices for all stocks:
   ```ruby
   all_prices = LatestStockPrice.price_all
   ```

Make sure to replace 'YOUR_API_KEY' with a valid API key from the Latest Stock Price service.
