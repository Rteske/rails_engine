class Api::V1::MerchantFacade
  class << self
    def merchants_index(params)
      if params[:page].nil? && params[:per_page].nil?
        Merchant.all.page(1)
      elsif params[:per_page].nil?
        Merchant.all.page(params[:page])
      else
        Merchant.all.page(params[:page]).per(params[:per_page])
      end
    end

    def merchant_show(params)
      if Merchant.last.id >= params[:id].to_i
        Merchant.find(params[:id])
      else
        raise ActiveRecord::RecordNotFound
      end
    end

    def item_merchant_show(params)
      if Item.last.id >= params[:item_id].to_i
        item = Item.find(params[:item_id])
        item.merchant
      else
        raise ActiveRecord::RecordNotFound
      end
    end

    def find_merchant(search_string)
      merchants = Merchant.search_by_name(search_string)
      if merchants.empty?
        raise ActiveRecord::RecordNotFound
      else
        merchants.first
      end
    end
  end
end
