class Instructor < ActiveRecord::Base 
  has_many   :assignments
  
  class SuperUser
    include Singleton
    @@key = "1234567890"
    def self.key
      @@key
    end
  end
  
end
