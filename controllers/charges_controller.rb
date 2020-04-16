# frozen_string_literal: true

class ChargesController < ApplicationController
  def new
    @amount = @cart.total_price
    @description = 'Description of Charge'
  end

  def create
    amount = @cart.total_price

    @customer = Stripe::Customer.create(email: params[:stripeEmail],
                                        source: params[:stripeToken])

    @charge = Stripe::Charge.create(customer: @customer.id,
                                    amount: amount,
                                    description: 'Rails Stripe customer',
                                    currency: 'cad')

    order = Order.create if @charge.paid && @charge.amount == amount
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
  end
end
