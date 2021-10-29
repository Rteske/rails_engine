class Api::V1::ItemQueryController < ApplicationController
  def find_all
    item = Api::V1::ItemFacade.find_all_items(params[:name])
    render json: Api::V1::ItemSerializer.new(item)
  end

  def items_revenue
    if params[:quantity].nil?
      items = Api::V1::RevenueFacade.items_revenue
      render json: Api::V1::ItemRevenueSerializer.new(items)
    elsif params[:quantity].scan('/\D/').any? || params[:quantity].to_i == 1
      items = Api::V1::RevenueFacade.items_revenue(params[:quantity].to_i)
      render json: Api::V1::ItemRevenueSerializer.new(items)
    elsif params[:quantity].to_i > Item.all.count
      items = Api::V1::RevenueFacade.items_revenue(Item.all.count)
      render json: Api::V1::ItemRevenueSerializer.new(items)
    else
      render json: "Invalid Params", status: 400
    end
  end
end
