# frozen_string_literal: true

class LineItem < ApplicationRecord
  belongs_to :rod
  belongs_to :cart

  def total_price
    rod.price.to_i * quantity.to_i
  end
end
