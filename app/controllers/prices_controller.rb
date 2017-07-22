class PricesController < ApplicationController

  respond_to do |format|
    format.html
    format.json { render json: PriceDatatable.new(view_context) }
  end

end
