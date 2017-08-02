class BuildFinish < ActiveRecord::Base
  def self.to_csv
    attributes = BuildFinish.attribute_names

    CSV.generate(headers: true) do |csv|
      csv << attributes

      all.each do |user|
        csv << attributes.map { |attr| user.send(attr) }
      end
    end
  end
end
