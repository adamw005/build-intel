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
    Price.all
    
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
