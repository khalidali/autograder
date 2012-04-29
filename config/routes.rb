Autograder::Application.routes.draw do

  #get "instructor/index"

  #get "instructor/authorize"

  #get "instructor/deauthorize"

  match 'assignments/create' => 'assignments#create', :via => :post
  match 'assignments/:id/update_autograder' => 'assignments#update_autograder', :via => :put
  match 'assignments/:id/add_student_keys' => 'assignments#add_student_keys', :via => :put
  match 'assignments/:id/remove_student_keys' => 'assignments#remove_student_keys', :via => :put
  match 'assignments/:id/change_due_date' => 'assignments#change_due_date', :via => :put
  match 'assignments/:id/submit' => 'assignments#submit', :via => :put
  match 'assignments/:id/retrieve_all_submissions' => 'assignments#retrieve_all_submissions', :via => :get
  match 'assignments/:id/retrieve_submissions_by_status' => 'assignments#retrieve_submissions_by_status', :via => :get
  match 'assignments/:id/retrieve_submission_by_student_key' => 'assignments#retrieve_submission_by_student_key', :via => :get
  
  match 'submissions/:id/update_status' => 'submissions#update_status', :via => :put
  
  
  get 'instructors(.:format)' => 'instructor#index', :defaults => { :format => 'json' }
  get 'instructors/authorize(.:format)' => 'instructor#authorize', :defaults => { :format => 'json' }
  get 'instructors/deauthorize(.:format)' => 'instructor#deauthorize', :defaults => { :format => 'json' }
 
  
  #match 'assignments/:id/find_by_list_of_keys' => 'assignments#find_by_list_of_keys', :via => :get
  #match 'assignments/:id/find_by_grading' => 'assignments#find_by_grading', :via => :get
  
  #resources :assignments, :only => [:create, :edit, :destroy ]
  

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
  # match ':controller(/:action(/:id(.:format)))'
end
