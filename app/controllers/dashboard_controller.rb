
require 'rake'

class DashboardController < ApplicationController
  before_action :authenticate_user!, only: :show

  def show
    @upload = Upload.new
  end

  def control
    nuke = dashboard_params[:nuke].presence
    search_skus = dashboard_params[:search_skus].presence
    scrape = dashboard_params[:scrape].presence

    if nuke
      SkuUrl.delete_all
      Price.delete_all
      BuildFinish.delete_all
      redirect_to dashboard_show_path
      return
    end

    Rails.application.load_tasks

    %i[search_skus scrape].each { |tk| Rake::Task[tk].reenable }

    if search_skus
      Rake::Task[:search_skus].invoke
      redirect_to dashboard_show_path
      return
    end

    Rake::Task[:scrape].invoke if scrape

    redirect_to dashboard_show_path
  end

  # Dashboard for AJAX (also add route)
  def three_line
    render json: Price.where("sku in ('RP84382RB','5600-3-AMB','5600-3-01')").group(:sku).group_by_day(:created_at).average(:price).chart_json
  end
  def brand_column
    render json: Price.group(:brand).count
  end
  def scrape_count
    render json: Price.group_by_day(:created_at).count
  end
  def price_popup
    find_sku = params[:sku].to_s
    render json: Price.where("sku in ('#{find_sku}')").group(:sku).group_by_day(:created_at).average(:price).chart_json
  end

  private

  def dashboard_params
    params.require(:dashboard).permit(:nuke, :search_skus, :scrape)
  end
end
