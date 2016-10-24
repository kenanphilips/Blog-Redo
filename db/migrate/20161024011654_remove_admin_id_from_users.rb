class RemoveAdminIdFromUsers < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :admin_id
  end
end
