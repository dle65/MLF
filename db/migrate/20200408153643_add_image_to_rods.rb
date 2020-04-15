class AddImageToRods < ActiveRecord::Migration[6.0]
  def change
    add_column :rods, :image, :string
  end
end
