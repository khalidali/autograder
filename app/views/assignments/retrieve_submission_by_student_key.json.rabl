if(@student_key_valid)
  collection @submissions 

  child :student do 
      attributes :student_key  
  end

  attributes :output, :body, :created_at
else
  object false => "Retrieval Failed, student_key not valid"
end

