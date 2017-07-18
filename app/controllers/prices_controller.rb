class PricesController < ApplicationController

  def index
    respond_to do |format|
      format.html
      format.json { render json: view_context }
    end
  end

end
