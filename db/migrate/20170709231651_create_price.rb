class CreatePrice < ActiveRecord::Migration
  def change
    create_table :prices do |t|
      t.string :site_name
      t.string :brand
      t.string :sku
      t.decimal :price
      t.integer :quantity
      t.references :tenant, index: true, foreign_key: true

      t.timestamps
    end
  end
end
