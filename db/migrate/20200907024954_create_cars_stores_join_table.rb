class CreateCarsStoresJoinTable < ActiveRecord::Migration[5.2]
  def change
    create_join_table :cars, :stores do |t|
      t.index :car_id
      t.index :store_id
    end
  end
end
