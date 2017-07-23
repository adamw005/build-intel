class Upload < ActiveRecord::Base
  has_attached_file :csv_file, url: ':s3_path_url'
  do_not_validate_attachment_file_type :csv_file
end
