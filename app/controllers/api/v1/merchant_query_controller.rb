class Api::V1::MerchantQueryController < ApplicationController
  def find
    merchant = Api::V1::MerchantFacade.find_merchant(params[:name])
    render json: Api::V1::MerchantSerializer.new(merchant)
  end

  def merchant_items_sold
    merchants = Api::V1::RevenueFacade.top_merchants_items_sold(params[:quantity])
    if merchants == 'Invalid Params'
      render json: 404, status: 404
    else
      render json: Api::V1::MerchantNameItemsSerializer.new(merchants), methods: :total_items_sold
    end
  end

  def merchants_revenue
    merchants = Api::V1::RevenueFacade.top_merchants_revenue(params[:quantity])
    if merchants == 'Invalid Params'
      render json: 404, status: 404
    else
      render json: Api::V1::MerchantNameRevenueSerializer.new(merchants), methods: :total_revenue
    end
  end

  def merchant_revenue
    merchant = Api::V1::RevenueFacade.merchant_revenue(params[:id])
    render json: Api::V1::MerchantRevenueSerializer.new(merchant), methods: :total_revenue
  end
end
