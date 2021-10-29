class Api::V1::MerchantItemsController < ApplicationController
  def index
    items = Api::V1::ItemFacade.merchant_items_index(params)
    render json: Api::V1::ItemSerializer.new(items)
  end
end
