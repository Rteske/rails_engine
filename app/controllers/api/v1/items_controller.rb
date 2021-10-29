class Api::V1::ItemsController < ApplicationController
  def index
    items = Api::V1::ItemFacade.items_index(params)
    render json: Api::V1::ItemSerializer.new(items)
  end

  def show
    item = Api::V1::ItemFacade.item_show(params)
    render json: Api::V1::ItemSerializer.new(item)
  end

  def create
    item = Item.new(item_params)
    if item.save
      render json: Api::V1::ItemSerializer.new(item), status: :created
    else
      render json: item.errors, status: 404
    end
  end

  def update
    item = Api::V1::ItemFacade.item_show(params)
    if item.update(item_params)
      render json: Api::V1::ItemSerializer.new(item)
    else
      render status: 404
    end
  end

  def destroy
    item = Api::V1::ItemFacade.item_show(params)
    item.destroy
  end

  private

  def item_params
    params.permit(:name, :description, :unit_price, :merchant_id)
  end
end
