class UploadsController < ApplicationController
  def new
    @upload = Upload.new
  end

  def create
    @upload = Upload.new upload_params
    if @upload.save
      redirect_to root
    else
      render :action => 'new'
    end
  end

	private

	def upload_params
		params.require(:upload).permit(:csv_file, :user_id)
	end
end
