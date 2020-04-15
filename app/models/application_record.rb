class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  def self.search(search)
    where('brand LIKE ?', "%#{search}")
  end
end
