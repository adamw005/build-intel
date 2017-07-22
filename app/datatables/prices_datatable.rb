class PricesDatatable < AjaxDatatablesRails::Base

  include AjaxDatatablesRails::Extensions::Kaminari

  def sortable_columns
    @sortable_columns ||= %w(Price.brand Price.sku Price.price)
    # this is equal to:
    # @sortable_columns ||= ['User.first_name', 'User.last_name', 'User.bio']
  end

  def searchable_columns
    @searchable_columns ||= %w(Price.brand Price.sku Price.price)
    # this is equal to:
    # @searchable_columns ||= ['User.first_name', 'User.last_name', 'User.bio']
  end

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
