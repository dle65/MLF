class AddCategoryIdToRods < ActiveRecord::Migration[6.0]
  def change
    add_column :rods, :category_id, :integer
  end
end
