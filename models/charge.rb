# frozen_string_literal: true

class Charge < ApplicationRecord
  belongs_to :cart
end
