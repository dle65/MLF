# frozen_string_literal: true

class Rod < ApplicationRecord
  before_destroy :not_referenced_by_any_line_item
  belongs_to :user, optional: true
  belongs_to :category
  has_many :line_items

  has_one_attached :image

  validates :title, :brand, :price, :color, :size, :stock_quantity, presence: true
  validates :description, length: { maximum: 1000, too_long: '%{count} characters is the maximum aloud. ' }
  validates :title, length: { maximum: 140, too_long: '%{count} characters is the maximum aloud. ' }
  def self.search(search)
    # @rods = Rod.where('brand LIKE ?', '%search%')
    where('brand LIKE ?', "%#{search}")
  end

  private

  def not_referenced_by_any_line_item
    unless line_items.empty?
      errors.add(:base, 'Line items present')
      throw :abort
    end
  end
end
