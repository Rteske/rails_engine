class Api::V1::RevenueFacade
  class << self
    def top_merchants_revenue(quantity = nil)
      if quantity.nil?
        'Invalid Params'
      else
        merchants = Merchant.merchants_by_revenue(quantity)
        merchants.each do |merchant|
          merchant.revenue = merchant.total_revenue
        end
        merchants
      end
    end

    def top_merchants_items_sold(quantity = 5)
      if quantity.to_i <= 0 && quantity.class != Integer
        'Invalid Params'
      else
        merchants = Merchant.merchants_by_items_sold(quantity)
        merchants.each do |merchant|
          merchant.count = merchant.total_items_sold
        end
        merchants
      end
    end

    def merchant_revenue(merchant_id)
      if Merchant.last.id >= merchant_id.to_i
        merchant = Merchant.find(merchant_id)
        merchant.revenue = merchant.revenue_by_merchant[0].total_revenue
        merchant
      else
        raise ActiveRecord::RecordNotFound
      end
    end

    def items_revenue(quantity = 10)
      items = Item.items_by_revenue(quantity)
      items.each do |item|
        item.revenue = item.total_revenue
      end
      items
    end
  end
end
