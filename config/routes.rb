Autograder::Application.routes.draw do

  # instructor routes  
  get 'instructors(/index(.:format))' => 'instructors#index', :defaults => { :format => 'json' }
  get 'instructors/status(.:format)' => 'instructors#status', :defaults => { :format => 'json' }
  get 'instructors/authorize(.:format)' => 'instructors#authorize', :defaults => { :format => 'json' }
  get 'instructors/deauthorize(.:format)' => 'instructors#deauthorize', :defaults => { :format => 'json' }

  # assignment routes
  post 'assignments/create(.:format)' => 'assignments#create', :defaults => { :format => 'json' }
  
  get 'assignments/:id/autograder' => 'assignments#get_autograder'
  put 'assignments/:id/autograder' => 'assignments#set_autograder'
  
  get 'assignments/:id/due_date(.:format)' => 'assignments#get_due_date', :defaults => { :format => 'json' }
  put 'assignments/:id/due_date(.:format)' => 'assignments#set_due_date', :defaults => { :format => 'json' }
  
  get 'assignments/:id/late_due_date(.:format)' => 'assignments#get_late_due_date', :defaults => { :format => 'json' }
  put 'assignments/:id/late_due_date(.:format)' => 'assignments#set_late_due_date', :defaults => { :format => 'json' }
  
  get 'assignments/:id/student_keys(/index(.:format))' => 'assignments#list_student_keys', :defaults => { :format => 'json' }
  put 'assignments/:id/student_keys/add(.:format)' => 'assignments#add_student_keys', :defaults => { :format => 'json' }
  put 'assignments/:id/student_keys/remove(.:format)' => 'assignments#remove_student_keys', :defaults => { :format => 'json' }
  
  put 'assignments/:id/submit(.:format)' => 'assignments#submit', :defaults => { :format => 'json' }
  
  get 'assignments/:id/submissions(/index(.:format))' => 'assignments#retrieve_submissions', :defaults => { :format => 'json' }
  
  mount Resque::Server, :at => "/resque"

end
