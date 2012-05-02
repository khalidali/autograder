Autograder::Application.routes.draw do

  # instructor routes  
  get 'instructors(/index(.:format))' => 'instructors#index', :defaults => { :format => 'json' }
  get 'instructors/status(.:format)' => 'instructors#status', :defaults => { :format => 'json' }
  put 'instructors/authorize(.:format)' => 'instructors#authorize', :defaults => { :format => 'json' }
  put 'instructors/deauthorize(.:format)' => 'instructors#deauthorize', :defaults => { :format => 'json' }

  # assignment routes
  post 'assignments/create(.:format)' => 'assignments#create', :defaults => { :format => 'json' }
  
  get 'assignments/:id/autograder' => 'assignments#get_autograder', :defaults => { :format => 'json' }
  put 'assignments/:id/autograder' => 'assignments#set_autograder', :defaults => { :format => 'json' }
  
  get 'assignments/:id/due_date(.:format)' => 'assignments#get_due_date', :defaults => { :format => 'json' }
  put 'assignments/:id/due_date(.:format)' => 'assignments#set_due_date', :defaults => { :format => 'json' }
  
  get 'assignments/:id/name(.:format)' => 'assignments#get_name', :defaults => { :format => 'json' }
  put 'assignments/:id/name(.:format)' => 'assignments#set_name', :defaults => { :format => 'json' }
  
  get 'assignments/:id/hard_deadline(.:format)' => 'assignments#get_hard_deadline', :defaults => { :format => 'json' }
  put 'assignments/:id/hard_deadline(.:format)' => 'assignments#set_hard_deadline', :defaults => { :format => 'json' }
  
  get 'assignments/:id/submissions_limit(.:format)' => 'assignments#get_submissions_limit', :defaults => { :format => 'json' }
  put 'assignments/:id/submissions_limit(.:format)' => 'assignments#set_submissions_limit', :defaults => { :format => 'json' }
  
  get 'assignments/:id/grading_strategy(.:format)' => 'assignments#get_grading_strategy', :defaults => { :format => 'json' }
  put 'assignments/:id/grading_strategy(.:format)' => 'assignments#set_grading_strategy', :defaults => { :format => 'json' }
  
  get 'assignments/:id/student_keys(/index(.:format))' => 'assignments#list_student_keys', :defaults => { :format => 'json' }
  put 'assignments/:id/student_keys/add(.:format)' => 'assignments#add_student_keys', :defaults => { :format => 'json' }
  put 'assignments/:id/student_keys/remove(.:format)' => 'assignments#remove_student_keys', :defaults => { :format => 'json' }
  
  put 'assignments/:id/submit(.:format)' => 'assignments#submit', :defaults => { :format => 'json' }
  
  get 'assignments/:id/submissions(/index(.:format))' => 'assignments#retrieve_submissions', :defaults => { :format => 'json' }
  
  mount Resque::Server, :at => "/resque"

end
