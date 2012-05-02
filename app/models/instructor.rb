class Instructor < ActiveRecord::Base 
  has_many   :assignments
end
