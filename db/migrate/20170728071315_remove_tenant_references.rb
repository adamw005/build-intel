class RemoveTenantReferences < ActiveRecord::Migration
  def change
    remove_reference :sku_urls, :tenant, index: true, foreign_key: true
    remove_reference :build_finishes, :tenant, index: true, foreign_key: true
  end
end
