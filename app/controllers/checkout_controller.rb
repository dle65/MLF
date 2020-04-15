# frozen_string_literal: true

class CheckoutController < ApplicationController
  def create
    Stripe.api_key = 'sk_test_2toYiV4LkJhE4krd8q7vDSG400YDkil5Ee'
    @session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      line_items: [{
        name: @rods,
        brand: @rods,
        description: @rods,
        color: @rod,
        size: @rods,
        price: @rods
      }],
      success_url: checkout_success_url,
      cancel_url: checkout_cancel_url
    )

    respond_to do |format|
      format.js
    end
  end
end
