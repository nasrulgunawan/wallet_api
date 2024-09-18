# README

### Create User, Team, and Stock
```ruby
  User.create!(email: "youremail@example.com", name: "Test User" password: "test1234", password_confirmation: "test1234")

  # Currently, does not have uniqueness index or validation
  Team.create!(name: "Team Name")
  Stock.create!(name: "Stock Name")
```

When you create the above entities, it automatically creates their own wallets.


## Authentication

The application provides two endpoints for user authentication:

### Login

- **URL:** `/users/login`
- **Method:** `POST`
- **Description:** Authenticates a user and returns a JWT token.
- **Request Body:**
  ```json
  {
    "email": "user@example.com",
    "password": "password123"
  }
  ```
- **Success Response:**
  - **Code:** 200 OK
  - **Content:**
    ```json
    {
      "message": "Logged in successfully",
      "user_id": 1,
      "token": "your.jwt.token"
    }
    ```
- **Error Response:**
  - **Code:** 401 Unauthorized
  - **Content:**
    ```json
    {
      "error": "Invalid email or password"
    }
    ```

### Logout

- **URL:** `/users/logout`
- **Method:** `DELETE`
- **Description:** Logs out the current user by invalidating their session token.
- **Headers:**
  - `Authorization: Bearer your.jwt.token`
- **Success Response:**
  - **Code:** 200 OK
  - **Content:**
    ```json
    {
      "message": "Logged out successfully"
    }
    ```
- **Error Response:**
  - **Code:** 422 Unprocessable Entity
  - **Content:**
    ```json
    {
      "error": "Failed to log out"
    }
    ```


## Transaction Operations

The application supports three types of transactions: deposits, withdrawals, and transfers. These operations are handled by the `Transaction` model.

### Creating a Deposit

To create a deposit transaction:
```ruby
  user = User.find(id)
  wallet = user.wallet
  amount = 1000000

  Transaction.deposit(wallet: wallet, amount: amount)
```

To Create a withdrawal transaction:
```ruby
  user = User.find(id)
  wallet = user.wallet
  amount = 1000000

  Transaction.withdraw(wallet: wallet, amount: amount)
```

To create a transfer transaction:
```ruby
  user = User.find(id)
  user_wallet = user.wallet

  team = Team.find(team_id)
  team_wallet = team.wallet

  amount = 100000

  Transaction.transfer(source_wallet: user_wallet, target_wallet: team_wallet, amount: amount)
```

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
