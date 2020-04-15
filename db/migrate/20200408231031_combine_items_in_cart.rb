# frozen_string_literal: true

class CombineItemsInCart < ActiveRecord::Migration[6.0]
  def up
    Cart.all.each do |cart|
      sums = cart.line_items.group(:rod_id).sum(:quantity)
      sums.each do |rod_id, quantity|
        next unless quantity > 1

        cart.line_items.where(rod_id: rod_id).delete_all

        item = cart.line_items.build(rod_id: rod_id)
        item.quantity = quantity
        item.save!
      end
    end
  end

  def down
    # split items with a quantity of 1 or more into multiple items
    LineItem.where('quantity>1').each do |line_item|
      line_item.quantity.times do
        LineItem.create(
          cart_id: line_item.cart_id,
          rod_id: line_item.rod_id,
          quantity: 1
        )
      end
      # remove original line item
      line_item.destroy
    end
  end
end
