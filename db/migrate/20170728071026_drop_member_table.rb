class DropMemberTable < ActiveRecord::Migration
  def change
    drop_table :members
  end
end
