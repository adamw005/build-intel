class PricesDatatable < AjaxDatatablesRails::Base

  def view_columns
    @view_columns ||= {
      brand: {source: 'Price.brand' },
      sku: {source: 'Price.sku' },
      # title: {source: 'Price.title' },
      price: {source: 'Price.price' }
    }
  end

  def data
    records.map do |record|
      [
        record.brand,
        record.sku,
        # title: record.title,
        record.price
      ]
    end
  end

  private

  def get_raw_records
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
