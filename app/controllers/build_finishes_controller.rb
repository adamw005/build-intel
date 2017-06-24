class BuildFinishesController < ApplicationController
	def new
		@build_finish = BuildFinish.new
	end

	def create
		@build_finish = BuildFinish.new build_finish_params.slice(BuildFinish.column_names)
		# @build_finish.attributes = hash.reject{|k,v| !@build_finish.attributes.keys.member?(k.to_s) }
		if @build_finish.save
			redirect_to :root
		else
			render :action => 'new'
		end
	end

	private

	def build_finish_params
		params.require(:build_finish).permit(:application, :productCompositeId, :manufacturer, :productId, :selectedFinish, :freeShippingMessage, :leadTimeMessage, :name, :masterFinish, :uniqueId, :msrp, :price, :consumerPrice, :sku, :title, :slug, :familyLink, :productLink, :savings, :stock, :swatchStyles, :swatchImage, :hideStock)
		params.require(:build_finish).permit(:friendlyStatus, :stockMessage, :isOutOfStock, :isMadeToOrder, :isPreOrder, :status, :savingsFromConsumerPrice, :image100x100, :image220x220, :isPaint, :images_defaultImg, :sale_productSaleId, :sale_catchLine, :sale_saleDetail, :sale_startDate, :sale_endDate, :savingsDetails_standard, :savingsDetails_total, :savingsDetails_percentage, :type_of)
	end


end
