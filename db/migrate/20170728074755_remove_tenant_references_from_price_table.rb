class RemoveTenantReferencesFromPriceTable < ActiveRecord::Migration
  def change
    remove_reference :prices, :tenant, index: true, foreign_key: true
  end
end
