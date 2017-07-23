class PriceDatatable < AjaxDatatablesRails::Base

  def view_columns
    # Declare strings in this format: ModelName.column_name
    # or in aliased_join_table.column_name format
    @view_columns ||= {
      brand: { source: "Price.brand" },
      sku: { source: "Price.sku" },
      price: { source: "Price.price" }
    }
  end

  def data
    records.map do |record|
      {
        brand: record.brand,
        sku: record.sku,
        price: record.price
      }
    end
  end

  private

  def get_raw_records
    # insert query here
    # Price.all
    sql="
    select a.brand, a.sku, avg(a.price) as avg_price, b.current_price
    from prices a
    left join (
    select x.brand, x.sku, x.price as current_price
    from prices x
    left join prices y
     on x.brand = y.brand and x.sku = y.sku and x.created_at < y.created_at
    where y.created_at IS NULL
    ) b
    on a.brand = b.brand and a.sku = b.sku
    group by 1,2,4
    "
    Price.select("*").from("(#{sql}) as subquery")


  end

  # ==== These methods represent the basic operations to perform on records
  # and feel free to override them

  # def filter_records(records)
  # end

  # def sort_records(records)
  # end

  # def paginate_records(records)
  # end

  # ==== Insert 'presenter'-like methods below if necessary
end
