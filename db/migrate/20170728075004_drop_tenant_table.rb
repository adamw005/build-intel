class DropTenantTable < ActiveRecord::Migration
  def change
    drop_table :tenants
  end
end
