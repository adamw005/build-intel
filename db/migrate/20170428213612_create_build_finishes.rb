class CreateBuildFinishes < ActiveRecord::Migration
  def change
    create_table :build_finishes do |t|
      t.string :application
      t.string :type_of
      t.string :productCompositeId
      t.string :manufacturer
      t.string :productId
      t.boolean :selectedFinish
      t.string :freeShippingMessage
      t.string :leadTimeMessage
      t.string :name
      t.string :masterFinish
      t.string :uniqueId
      t.decimal :msrp
      t.decimal :price
      t.decimal :consumerPrice
      t.string :sku
      t.string :title
      t.string :slug
      t.string :familyLink
      t.string :productLink
      t.decimal :savings
      t.integer :stock
      t.string :swatchStyles
      t.string :swatchImage
      t.boolean :hideStock
      t.string :friendlyStatus
      t.string :stockMessage
      t.boolean :isOutOfStock
      t.boolean :isMadeToOrder
      t.boolean :isPreOrder
      t.string :status
      t.decimal :savingsFromConsumerPrice
      t.string :image100x100
      t.string :image220x220
      t.boolean :isPaint
      t.string :images_defaultImg
      t.string :sale_productSaleId
      t.string :sale_catchLine
      t.string :sale_saleDetail
      t.datetime :sale_startDate
      t.datetime :sale_endDate
      t.decimal :savingsDetails_standard
      t.decimal :savingsDetails_total
      t.integer :savingsDetails_percentage

      t.timestamps null: false
    end
  end
end
