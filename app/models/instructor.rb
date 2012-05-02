class Instructor < ActiveRecord::Base 
  has_many   :assignments
  validates_uniqueness_of :key
  
  class SuperUser
    include Singleton
    @@key = "1234567890"
    def self.key
      @@key
    end
    def self.key=(key)
      @@key = key
    end
  end
  
end
