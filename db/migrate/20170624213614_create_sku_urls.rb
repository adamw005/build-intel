class CreateSkuUrls < ActiveRecord::Migration
  def change
    create_table :sku_urls do |t|
      t.string :manuf
      t.string :sku
      t.string :url

      t.timestamps null: false
    end
  end
end
