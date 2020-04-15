# frozen_string_literal: true

class CreateRods < ActiveRecord::Migration[6.0]
  def change
    create_table :rods do |t|
      t.string :brand
      t.text :description
      t.integer :stock_quantity
      t.string :title
      t.decimal :price, precision: 5, scale: 2, default: 0
      t.string :color
      t.decimal :size

      t.timestamps
    end
  end
end
