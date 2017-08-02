class Price < ActiveRecord::Base
  def self.to_csv
    attributes = Price.attribute_names
    # attributes = %w[brand sku title price site_name quantity]

    CSV.generate(headers: true) do |csv|
      csv << attributes

      all.each do |user|
        csv << attributes.map { |attr| user.send(attr) }
      end
    end
  end
end
