class AddTenantToSkuUrl < ActiveRecord::Migration
  def change
    add_reference :sku_urls, :tenant, index: true, foreign_key: true
    add_reference :build_finishes, :tenant, index: true, foreign_key: true
  end
end
