IntacWebPortal::Application.routes.draw do
  get "ember/index"
  get "ember" => "ember#index"

  get "home/home"
  get "admin/admin_home"
  post "admin/update_employee"
  post "admin/update_customer"
  post "admin/delete_users"
  post "admin/update_role"
  get "/admin/edit_role"
  post "admin/create_role"
  get "admin/role_list"
  post "admin/resource_update"
  get "admin/resource_update"
  get "employees/employee_home"
  post "employees/update_row"
  get "employees/employee_update"
   get "/admin/update_user"
   get "/admin/inactive"
  get "customers/customer_home"
  post "customers/update_row"
  get "customers/customer_update"
  get "customers/customer_profile"
  get "customers/add_job"
  get "admin/manage_user"
  get "search/search_user"
  get "search/search_role"
  #get "admin/add_roles"
  post "admin/create"
  match 'add_role' =>'admin#add_roles' ,:as=>'admin'
  get "password_resets/new"
   
  get "sessions/new"
  get "users/customer_profile"
  get "users/new"
get "log_out" => "sessions#destroy", :as => "log_out"
get "log_in" => "sessions#new", :as => "log_in"
get "sign_up" => "users#new", :as => "sign_up"
get "sign_up_customer"=>"customers#new" ,:as=>"sign_up_customer"
get "sign_up_employee"=>"employees#new" ,:as=>"sign_up_employee"

root :to => "home#home"
resources :users
resources :sessions
resources :password_resets
resources :customers
resources :employees
#resources :admin
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
