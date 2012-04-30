class AssignmentsController < ApplicationController
  #before_filter :authenticate_prof, :except => [:submit]
  before_filter :find_assignment, :except => [:create]
  
  def create 
    due_date = params[:due_date].to_time unless params[:due_date] == nil or is_valid_date?(params[:due_date])  
    late_due_date = params[:late_due_date].to_time unless params[:late_due_date] == nil or is_valid_date?(params[:late_due_date])         
    autograder = get_file_contents(params[:autograder]) unless params[:autograder] == nil

    
    @assignment = Assignment.create(:prof_key => params[:prof_key], 
                                    :due_date => due_date, 
                                    :late_due_date => late_due_date,
                                    :autograder => autograder)
                                    
    if(params[:student_keys] != nil)
       student_keys = parse_array(params[:student_keys])
       @added_student_keys, @rejected_student_keys = @assignment.add_student_keys(student_keys)
    end
         
    @assignment.save()
  end
  
  def get_autograder
  end
  
  def set_autograder
    @assignment = Assignment.find_by_id(params[:id])
    if not params[:autograder] then
      render :text => 'ERROR: required param \'autograder\' missing.'
    else
      @assignment.autograder = get_file_contents(params[:autograder])
      @assignment.save
    end
  end
  
  def get_due_date
  end
  
  def set_due_date
    @assignment = Assignment.find_by_id(params[:id])
    due_date = params[:due_date].to_time unless params[:due_date] == nil or is_valid_date?(params[:due_date])
    if(due_date != nil)
      @assignment.due_date = due_date
      @assignment.save
    else
      render :text => 'ERROR: invalid or missing param \'due_date\'.'
    end
  end
  
  def get_late_due_date
  end
  
  def set_late_due_date
      late_due_date = params[:late_due_date].to_time unless params[:late_due_date] == nil or is_valid_date?(params[:late_due_date]) 
    if(late_due_date != nil)
      @assignment.change_late_due_date(late_due_date)
      @assignment.save
    else
      render :text => 'ERROR: invalid or missing param \'late_due_date\'.'
    end
  end
  
  def list_student_keys
      @students = @assignment.students
  end
  
  def add_student_keys
    if not params[:keys] 
      render :text => 'ERROR: required param \'keys\' missing.'
    else
      @students = @assignment.add_student_keys(parse_array(params[:keys]))
      @assignment.save
    end
  end
  
  def remove_student_keys
    if not params[:keys] 
      render :text => 'ERROR: required param \'keys\' missing.'
    else
      @students = @assignment.remove_student_keys(parse_array(params[:keys]))
      @assignment.save
    end
  end
  
  def submit
    @assignment = Assignment.find_by_id params[:id]
    @student = @assignment.students.find_by_key params[:key]
    if not @student and not params[:submission] then
      render :text => 'ERROR: student key doesn\'t exist and required param \'submission\' missing.'
    else if not @student then
      render :text => 'ERROR: student key doesn\'t exist.'
    else if not params[:submission] then
      render :text => 'ERROR: required param \'submission\' missing.'
    else
      submission = get_file_contents(params[:submission])
      @submission = @student.add_submission(submission)
      @student.save()
      @submission_successful = true
    end
  end
  
  def retrieve_submissions
      @submissions = @assignment.submissions
    if(params[:keys])
      @submissions = Student.find_all_by_key(parse_array(params[:keys])).map{|student| student.submissions}.flat_map{|i| i}
    end
    if(params[:status])
      @submissions = @submissions.find_all_by_status(params[:status])
    end
  end
  
  private
    
  def get_file_contents(uploadedfile)
    File.open(uploadedfile.tempfile.path, "rb").read()
  end
  
  def is_valid_date?(date)
    date =~ /^[0-9]{4}-[0-9]{1,2}-[0-9]{1,2} [0-9]{1,2}:[0-9]{1,2}:[0-9]{1,2}( -[0-9]{4})?$/
  end
  
  def authenticate_prof 
    return True
    #Professor.find_by_prof_key(params[:prof_key])
  end
   
  def find_assignment
  @assignment = Assignment.find_by_id(params[:id])
      if not @assignment then
      render :text => 'ERROR: assignment does not exist' 
    end 
  end 
end
