class InstructorsController < ApplicationController
  before_filter :authenticate_super_user
  
  def index
    @instructors = Instructor.find(:all)
  end
  
  def status
    if not params[:keys] then
      render :text => 'required param \'keys\' missing.'
    else
      @instructors = Hash.new
      parse_array(params[:keys]).each { |key| @instructors[key] = is_instructor?(key) ? 'authorized' : 'unauthorized' }
    end
  end

  def authorize
    if not params[:keys] then
      render :text => 'required param \'keys\' missing.'
    else
      @instructors = Hash.new
      parse_array(params[:keys]).each do |key|
        if is_instructor? key then
          @instructors[key] = 'ERROR: Key already authorized'
        else
          Instructor.create! :key => key
          @instructors[key] = 'authorized'
        end
      end
    end
  end

  def deauthorize
    if not params[:keys] then
      render :text => 'required param \'keys\' missing.'
    else
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
  
  def authenticate_super_user
    if Instructor::SuperUser.key != params[:super_key] 
      render :text => 'ERROR: SuperUser key required for this action.'
    end
  end
end
