class PricesController < ApplicationController

  def index
    respond_to do |format|
      format.html
      format.json { render json: ::PriceDatatable.new(view_context) }
    end
  end

end
