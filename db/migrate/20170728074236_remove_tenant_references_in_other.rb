class RemoveTenantReferencesInOther < ActiveRecord::Migration
  def change
    remove_reference :users, :tenant, index: true
  end
end
