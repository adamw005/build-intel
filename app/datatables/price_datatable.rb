class PriceDatatable < AjaxDatatablesRails::Base

  def view_columns
    @view_columns ||= {
      manufacturer: {source: 'Price.manufacturer' },
      sku: {source: 'Price.sku' },
      title: {source: 'Price.title' },
      price: {source: 'Price.price' }
    }
  end

  def data
    records.map do |record|
      {
        manufacturer: record.manufacturer,
        sku: record.sku,
        title: record.title,
        price: record.price
      }
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
