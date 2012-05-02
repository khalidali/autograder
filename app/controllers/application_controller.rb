class ApplicationController < ActionController::Base
  protect_from_forgery
  respond_to :json
  
  private
  
  def parse_array(array)
    array[1..-2].split(',').each { |e| e.strip! }
  end
  
  def is_assignment?(id)
    Assignment.find_by_id id
  end
  
  def is_instructor?(key)
    Instructor.find_by_key key
  end
  
  def is_student?(key)
    Student.find_by_key key
  end
  
  def is_grading_strategy?(strategy)
    valid_strategies = ["max","latest"]
    valid_strategies.include? strategy
  end
end
