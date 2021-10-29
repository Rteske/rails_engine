class Api::V1::MerchantsController < ApplicationController
  def index
    merchants = Api::V1::MerchantFacade.merchants_index(params)
    render json: Api::V1::MerchantSerializer.new(merchants)
  end

  def show
    merchant = Api::V1::MerchantFacade.merchant_show(params)
    render json: Api::V1::MerchantSerializer.new(merchant)
  end
end
