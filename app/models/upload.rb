class Upload < ActiveRecord::Base
  has_attached_file :csv_file
  do_not_validate_attachment_file_type :csv_file

  def initialize(params = {})
    file = params.delete(:file)

    super

    return if !file

    # self.filename = File.basename(file.original_filename)
    # self.content_type = file.content_type
    # self.file_contents = file.read

    # self.filename = File.basename(file.original_filename)
    # self.content_type = file.content_type
    self.csv_file_contents = file.read

    # Why start at 1? To exclude the field titles row.
    CSV.parse(csv_file_contents)[1..-1].each do |row|
      SkuUrl.create!(manuf: row.first, sku: row.last)
    end
  end
end
