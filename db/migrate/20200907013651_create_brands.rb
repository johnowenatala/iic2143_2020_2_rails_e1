class CreateBrands < ActiveRecord::Migration[5.2]
  def change
    ActiveModel
    create_table :brands do |t|
      t.string :name

      t.timestamps
    end
    add_index :brands, :name, unique: true
  end
end
