Autograder::Application.routes.draw do

  # instructor routes  
  get 'instructors(.:format)' => 'instructor#index', :defaults => { :format => 'json' }
  get 'instructors/authorize(.:format)' => 'instructor#authorize', :defaults => { :format => 'json' }
  get 'instructors/deauthorize(.:format)' => 'instructor#deauthorize', :defaults => { :format => 'json' }

  # assignment routes
  post 'assignments/create(.:format)' => 'assignments#create', :defaults => { :format => 'json' }
  put 'assignments/:id/update_autograder(.:format)' => 'assignments#update_autograder', :defaults => { :format => 'json' }
  put 'assignments/:id/add_student_keys(.:format)' => 'assignments#add_student_keys', :defaults => { :format => 'json' }
  put 'assignments/:id/remove_student_keys(.:format)' => 'assignments#remove_student_keys', :defaults => { :format => 'json' }
  put 'assignments/:id/change_due_date(.:format)' => 'assignments#change_due_date', :defaults => { :format => 'json' }
  put 'assignments/:id/submit(.:format)' => 'assignments#submit', :defaults => { :format => 'json' }
  get 'assignments/:id/retrieve_all_submissions(.:format)' => 'assignments#retrieve_all_submissions', :defaults => { :format => 'json' }
  get 'assignments/:id/retrieve_submissions_by_status(.:format)' => 'assignments#retrieve_submissions_by_status', :defaults => { :format => 'json' }
  get 'assignments/:id/retrieve_submission_by_student_key(.:format)' => 'assignments#retrieve_submission_by_student_key', :defaults => { :format => 'json' }

end
