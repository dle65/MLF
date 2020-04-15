class AddUserIdToRods < ActiveRecord::Migration[6.0]
  def change
    add_column :rods, :user_id, :integer
  end
end
