class DashboardController < ApplicationController
  def show
    # TODO: show content only for User's Tenant (waiting on bug fix)
  end

  def three_line
    render json: Price.where("sku in ('RP84382RB','5600-3-AMB','5600-3-01')").group(:sku).group_by_day(:created_at).average(:price).chart_json
  end
  def brand_column
    render json: Price.group(:brand).count
  end
end
