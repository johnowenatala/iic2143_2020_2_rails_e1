class RenameModelToOldModelOnCars < ActiveRecord::Migration[5.2]
  def change
    rename_column :cars, :model, :old_model
    rename_column :cars, :brand, :old_brand
  end
end
