# frozen_string_literal: true

class Cart < ApplicationRecord
  has_many :line_items, dependent: :destroy

  def add_rod(rod)
    current_item = line_items.find_by(rod_id: rod.id)

    if current_item
      current_item.increment(:quantity)
    else
      current_item = line_items.build(rod_id: rod.id)
    end
    current_item
  end

  def total_price
    line_items.to_a.sum(&:total_price)
  end
end
