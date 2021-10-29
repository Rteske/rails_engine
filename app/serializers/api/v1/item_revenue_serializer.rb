class Api::V1::ItemRevenueSerializer
  include JSONAPI::Serializer
  attributes :name, :description, :unit_price, :merchant_id, :revenue
end