class AddTitleToPrice < ActiveRecord::Migration
  def change
    add_column :prices, :title, :string
  end
end
