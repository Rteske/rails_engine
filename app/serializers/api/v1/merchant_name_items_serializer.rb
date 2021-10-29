class Api::V1::MerchantNameItemsSerializer
  include JSONAPI::Serializer
  attribute :name, :count
end
