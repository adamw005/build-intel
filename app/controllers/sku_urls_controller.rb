class SkuUrlsController < ApplicationController
	def new
		@sku_url = SkuUrl.new
	end

	def create
		@sku_url = SkuUrl.new sku_url_params
		# @sku_url.attributes = hash.reject{|k,v| !@sku_url.attributes.keys.member?(k.to_s) }
		if @sku_url.save
			redirect_to :root
		else
			render :action => 'new'
		end
	end

	private

	def sku_url_params
		params.require(:sku_url).permit(:manuf, :sku, :url)
	end


end
