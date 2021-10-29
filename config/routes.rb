Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      get 'merchants/find', to: 'merchant_query#find'
      get 'merchants/most_items', to: 'merchant_query#merchant_items_sold'

      scope :revenue do
        get 'merchants', to: 'merchant_query#merchants_revenue'
        get 'merchants/:id', to: 'merchant_query#merchant_revenue'
        get 'items', to: 'item_query#items_revenue'
      end

      get 'items/find_all', to: 'item_query#find_all'

      resources :merchants, only: [:index, :show] do
        resources :items, controller: :merchant_items, only: :index
      end

      resources :items do
        get 'merchant', to: 'item_merchant#index'
      end
    end
  end
end
