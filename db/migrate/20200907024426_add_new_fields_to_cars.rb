class AddNewFieldsToCars < ActiveRecord::Migration[5.2]
  def change
    change_table :cars do |t|
      t.integer :year
      t.integer :transmission, null: false, default: Car.transmissions[:manual]
      t.string :description
    end
  end
end
