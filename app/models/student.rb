class Student < ActiveRecord::Base

  belongs_to :assignment 
  has_many   :submissions 
  
end
