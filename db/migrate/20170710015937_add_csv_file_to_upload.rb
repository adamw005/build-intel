class AddCsvFileToUpload < ActiveRecord::Migration
  def change
    add_attachment :uploads, :csv_file
  end
end
