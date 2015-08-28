Rails.application.routes.draw do
 
    root 'root_pages#home'

  devise_for :users

  # try this if routing bugs happen
  # resources :users_admin, :controller => 'users', only: [:edit, :index, :show, :destroy, :update]

  # create routes so that Devise is not used for these functions
  resources :users, only: [:index, :show, :edit, :update, :destroy]
  resources :articles
  resource :cart, only: [:show]
  resources :orders
  get 'deliver_order', to: 'orders#deliver_order'
  resources :order_items, only: [:create, :update, :destroy]

  # routes for acts_as_votable
  resources :articles do
    member do
      put "like", to: "articles#upvote"
      put "dislike", to: "articles#downvote"
    end
  end

  get 'bestellen', to: 'articles#bestellen'
  get 'confirm_order', to: 'carts#confirm_order'
  post 'confirm_order_details', to: 'carts#confirm_order_details'
  get 'cancel_order',  to: 'carts#cancel_order'
  get 'meine_bestellungen', to: 'orders#user_orders'

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
