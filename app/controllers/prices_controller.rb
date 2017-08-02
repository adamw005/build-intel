class PricesController < ApplicationController

  def index
    respond_to do |format|
      format.html
      format.json { render json: PriceDatatable.new(view_context) }
      format.csv do
        send_data Price.all.to_csv, filename: "prices-#{Time.zone.today}.csv"
      end
    end
  end

end
