class CreatePrice < ActiveRecord::Migration
  def change
    create_table :prices do |t|
      t.string :site_name
      t.string :brand
      t.string :sku
      t.numeric :price
      t.numeric :quantity
    end
  end
end
