# TODO: Handle User, Team, and Stock Wallets

# class TransactionsController < ApplicationController
#   before_action :authenticate_user
#   before_action :to_decimal_amount, only: [ :deposit, :withdraw, :transfer ]

#   def deposit
#     Transaction.create_deposit(wallet: current_user.wallet, amount: @amount)

#     render json: {
#       message: "Deposit successful",
#       amount: @amount,
#       balance: current_user.wallet.balance
#     }, status: :ok
#   end

#   def withdraw
#     Transaction.create_withdrawal(wallet: current_user.wallet, amount: @amount)

#     render json: {
#       message: "Withdrawal successful",
#       amount: @amount,
#       balance: current_user.wallet.balance
#     }, status: :ok
#   end

#   def transfer
#     target_user = User.find_by(email: params[:target_email])
#     raise ActionController::BadRequest, "Target user not found" if target_user.blank?

#     target_wallet = target_user.wallet

#     Transaction.create_transfer(source_wallet: current_user.wallet, amount: @amount, target_wallet: target_wallet)

#     render json: {
#       message: "Transfer successful",
#       amount: @amount,
#       balance: current_user.wallet.balance
#     }, status: :ok
#   end

#   private

#   def to_decimal_amount
#     @amount = BigDecimal(params[:amount])
#   end
# end
