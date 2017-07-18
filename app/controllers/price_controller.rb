class PriceController < ApplicationController

  def index
    respond_to do |format|
      format.html
      format.json { render json: ::UserDatatable.new(view_context) }
    end
  end

end
