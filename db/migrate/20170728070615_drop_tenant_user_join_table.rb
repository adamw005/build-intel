class DropTenantUserJoinTable < ActiveRecord::Migration
  def change
    drop_join_table :tenants, :users
  end
end
