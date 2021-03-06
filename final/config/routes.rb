Rails.application.routes.draw do

  # for user login/session creation
  root 'sessions#new'
  get '/login' => 'sessions#new', as: :login
  get '/login/about' => 'sessions#info'
  post '/login' => 'sessions#create'
  delete '/logout' => 'sessions#destroy', as: :logout

  # for user profile
  post '/users' => 'users#create', as: :new_user
  get '/users/edit' => 'users#edit', as: :edit_user
  patch '/users/update' => 'users#update', as: :update_user

  # update preference from report
  post '/preferences/:tag_id' => 'preferences#create'

  # update favorite
  post '/favorites/:report_id' => 'favorites#create'
  delete '/favorites/:report_id' => 'favorites#destroy'

  # RESTful for reports
  resources :reports

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
