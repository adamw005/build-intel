class Price < ActiveRecord::Base

  def self.current_price
    select("x.brand, x.sku, x.price as current_price from prices x left join prices y on x.brand = y.brand and x.sku = y.sku and x.created_at < y.created_at where y.created_at IS NULL")
  end

end
