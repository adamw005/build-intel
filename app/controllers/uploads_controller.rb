class UploadsController < ApplicationController
  def new
    @upload = Upload.new
  end

  def create
    @upload = Upload.new upload_params
    if @upload.save
      redirect_to root_path
    else
      render :action => 'new'
    end

    path_to_s3 = 'https:' + @upload.csv_file.url

    # TODO NEXT: Parse through CSV file and save to SkuUrl
    CSV.new(open(path_to_s3)).each do |row|
      SkuUrl.create(manuf: row[0], sku: row[1], tenant_id: 13)
    end

  end

	private

	def upload_params
		params.require(:upload).permit(:csv_file, :user_id)
	end
end
