class InstructorController < ApplicationController
  def index
    @instructors = Instructor.find(:all)
  end

  def authorize
    @instructors = Hash.new
    parse_array(params[:keys]).each do |key|
      if Instructor.find_by_key(key) then
        @instructors[key] = 'ERROR: Key already authorized'
      else
        Instructor.create! :key => key
        @instructors[key] = 'authorized'
      end
    end
  end

  def deauthorize
    @instructors = Hash.new
    parse_array(params[:keys]).each do |key|
      @instructor = Instructor.find_by_key(key)
      if @instructor then
        @instructors[key] = 'deauthorized' and @instructor.delete
      else
        @instructors[key] = 'ERROR: Key not found'
      end
    end
  end
  
end
