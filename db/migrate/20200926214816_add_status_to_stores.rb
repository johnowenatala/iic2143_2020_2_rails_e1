class AddStatusToStores < ActiveRecord::Migration[5.2]
  def change
    add_column :stores, :status, :integer, after: :name, default: 1
  end
end
