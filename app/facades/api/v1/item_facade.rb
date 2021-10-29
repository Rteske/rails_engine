class Api::V1::ItemFacade
  class << self
    def items_index(params)
      if params[:page].nil? && params[:per_page].nil?
        Item.all.page(1)
      elsif params[:per_page].nil?
        Item.all.page(params[:page])
      else
        Item.all.page(params[:page]).per(params[:per_page])
      end
    end

    def item_show(params)
      if Item.last.id >= params[:id].to_i
        Item.find(params[:id])
      else
        raise ActiveRecord::RecordNotFound
      end
    end

    def merchant_items_index(params)
      if Merchant.last.id >= params[:merchant_id].to_i
        merchant = Merchant.find(params[:merchant_id])
        merchant.items
      else
        raise ActiveRecord::RecordNotFound
      end
    end

    def find_all_items(search_string)
      items = Item.search_all_items_by_name(search_string)
      if items.empty?
        raise ActiveRecord::RecordNotFound
      else
        items
      end
    end
  end
end
