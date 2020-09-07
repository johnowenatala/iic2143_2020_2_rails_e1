class AddModelReferenceToCars < ActiveRecord::Migration[5.2]
  def change
    change_table :cars do |t|
      t.references :model, after: :id, foreign_key: true
    end
  end
end
