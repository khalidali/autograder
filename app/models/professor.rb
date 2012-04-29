class Professor < ActiveRecord::Base
  has_many :assignments
end
