class Api::V1::ItemMerchantController < ApplicationController
  def show
    merchant = Api::V1::MerchantFacade.item_merchant_show(params)
    render json: Api::V1::MerchantSerializer.new(merchant)
  end
end
