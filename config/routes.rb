Rails.application.routes.draw do
  get 'roles' => 'roles#index'
  get 'employees/serve/:id'=>'employees#serve',:as=>'download'
  post 'roles/create'
  post '/user_data/user_active'
  post 'roles/update'
  get 'roles/edit'
  get 'roles/search_roles'
  post 'employees/update_row'
  get 'employees/update_row'
  get 'user_data/index'
  get 'user_data/search_users'
  post 'user_data/active_user'
  post 'user_data/edit_user'
  post 'user_data/update_user'
  get "user_data/sorting"
  get "roles/sorting"
  devise_for :users,:controllers => { :sessions => "json_sessions" ,:registrations => "registrations" ,:passwords=>"passwords"}
  devise_scope :user do
   post 'edit_password_em', :to => 'passwords#edit_password_em'
  end
  
  resources :customers
  resources :employees
  resource :user_data
  root :to=>'home#index'
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
