if(@submission_successful) 
  object @student => "Submission Successful"
  attributes :student_key
else
  object false => "Submission Failed, student_key not found"
end


