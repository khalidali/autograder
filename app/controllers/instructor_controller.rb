class InstructorController < ApplicationController
  def index
    @instructors = Instructors.all
  end

  def authorize
    @instructors = Hash.new
    params[:keys][1..-2].split(',').each { |e| e.strip! }.each |key| do
      @instructors[key] = 'ERROR: Key already authorized' if Instructor.find_by_key('key') not nil
      @instructors[key] = 'authorized' if Instructor.create! :key => key
    end
  end

  def deauthorize
    @instructors = Hash.new
    params[:keys][1..-2].split(',').each { |e| e.strip! }.each |key| do
      @instructors[key] = 'ERROR: Key not found' if Instructor.find_by_key('key') nil
      @instructors[key] = 'deauthorized' and @instructor.delete
    end
end
