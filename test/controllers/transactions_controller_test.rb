require "test_helper"

class TransactionsControllerTest < ActionDispatch::IntegrationTest
  test "should get deposit" do
    get transaction_deposit_url
    assert_response :success
  end

  test "should get withdraw" do
    get transaction_withdraw_url
    assert_response :success
  end

  test "should get transfer" do
    get transaction_transfer_url
    assert_response :success
  end
end
