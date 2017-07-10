class UploadsController < ApplicationController
  def new
    @upload = Upload.new
  end

  def create
    @upload = Upload.new upload_params
    if @upload.save
      redirect_to projects_path(@upload.project_id)
    else
      render :action => 'new'
    end
  end

  def show
    @upload = Upload.find(params[:hashid])
    redirect_to @upload.file.url
  end

	private

	def upload_params
		params.require(:upload).permit(:csv_file, :user_id)
	end
end
