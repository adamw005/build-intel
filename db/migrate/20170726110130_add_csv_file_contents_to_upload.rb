class AddCsvFileContentsToUpload < ActiveRecord::Migration
  def change
    add_column :uploads, :csv_file_contents, :binary
  end
end
