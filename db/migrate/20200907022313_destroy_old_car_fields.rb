class DestroyOldCarFields < ActiveRecord::Migration[5.2]
  def up
    change_table :cars do |t|
      t.remove :old_model, :old_brand
    end
  end

  def down
    change_table :cars do |t|
      t.string :old_model
      t.string :old_brand
    end
  end
end
