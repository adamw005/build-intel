class AddProductLinkToPrice < ActiveRecord::Migration
  def change
    add_column :prices, :product_link, :string
  end
end
