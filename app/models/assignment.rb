class Assignment < ActiveRecord::Base

  has_many :students
  has_many :submissions, :through => :students
  
    
  
end
