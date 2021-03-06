Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }

  root 'searches#show'

  # user section
  resource :search, only: [:new, :show]

  resources :users, shallow: true, only: [] do
    resources :tickets, only: [:index]
  end

  resources :trains, shallow: true, only: [] do
    resources :tickets, except: [:edit, :update]
  end

  namespace :admin do
    root 'welcome#index'
    resources :routes
    
    resources :railway_stations do
      patch 'update_time_position', on: :member
    end

    resources :trains, shallow: true do
      patch 'update_sorting', on: :member
      resources :coaches
      resources :tickets, except: [:new, :create]
      resources :compartment_coaches, controller: 'coaches', type: 'CompartmentCoach'
      resources :economy_coaches, controller: 'coaches', type: 'EconomyCoach' 
      resources :sleeping_coaches, controller: 'coaches', type: 'SleepingCoach'
      resources :suburban_coaches, controller: 'coaches', type: 'SuburbanCoach'
    end
  end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
