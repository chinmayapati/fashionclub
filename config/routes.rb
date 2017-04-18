Rails.application.routes.draw do

  get 'recover/recover'

  get 'recover/show'

  root 'home#index'

  get 'checkout/checkout'
  get 'checkout/checkout_payment'
  get 'checkout/checkout_review'
  get 'checkout/check'

  # Accounts Routes
  get 'accounts/dashboard'
  get 'accounts/profile'
  post 'accounts/profile'
  post 'accounts/create'
  get 'accounts/address'
  post 'accounts/address'
  get 'accounts/addaddress'
  post 'accounts/addaddress'
  get 'accounts/orders'
  get 'accounts/singleorder'
  get 'accounts/wishlist'
  get 'accounts/warranty'
  resources :accounts

  # Home Routes
  get 'home' => 'home#index'
  get 'home/product'
  get 'home/index'
  get 'home/cart'
  get 'home/checkout'
  get 'home/review'
  post 'home/review'
  get 'home/payment'
  get 'home/single_product'
  get 'home/stores'
  get 'home/tac'
  get 'home/privacy'
  get 'home/faq'
  get 'home/aboutus'

  # Sign up Routes
  get 'signup' =>  'signup#index'
  resources :signup

  # Sign in Routes
  get 'signin' => 'signin#index'
  post 'signin' => 'signin#create'
  delete 'logout' => 'signin#destroy'


  get 'recover' =>'recover#index'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

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
