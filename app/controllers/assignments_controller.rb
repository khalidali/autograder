class AssignmentsController < ApplicationController
  #before_filter :authenticate_prof, :except => [:submit]
  
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
    @assignment = Assignment.find_by_id(params[:id])
  end
  
  def set_autograder
    @assignment = Assignment.find_by_id(params[:id])
    if(params[:autograder] != nil)
      @assignment.autograder = get_file_contents(params[:autograder])
      @assignment.save
    end
  end
  
  def get_due_date
    @assignment = Assignment.find_by_id(params[:id])
  end
  
  def set_due_date
    @assignment = Assignment.find_by_id(params[:id])
    due_date = params[:due_date].to_time unless params[:due_date] == nil or is_valid_date?(params[:due_date]) 
    if(due_date != nil)
      @assignment.change_due_date(due_date)
      @assignment.save
    else
      render :text => 'invalid or missing param \'due_date\'.'
    end
  end
  
  def get_late_due_date
    @assignment = Assignment.find_by_id(params[:id])
  end
  
  def set_late_due_date
    @assignment = Assignment.find_by_id(params[:id])
    late_due_date = params[:late_due_date].to_time unless params[:late_due_date] == nil or is_valid_date?(params[:late_due_date]) 
    if(late_due_date != nil)
      @assignment.change_late_due_date(late_due_date)
      @assignment.save
    else
      render :text => 'invalid or missing param \'late_due_date\'.'
    end
  end
  
  def list_student_keys
    @assignment = Assignment.find_by_id(params[:id])
    if not @assignment then
      render :text => 'ERROR: assignment does not exist'
    else
      @students = @assignment.students
    end
  end
  
  def add_student_keys
    if not [:keys] 
      render :text => 'required param \'keys\' missing.'
    else
      @assignment = Assignment.find_by_id(params[:id])
      @students = @assignment.add_student_keys(parse_array(params[:keys]))
      @assignment.save
    end
  end
  
  def remove_student_keys
    if not [:keys] 
      render :text => 'required param \'keys\' missing.'
    else
      @assignment = Assignment.find_by_id(params[:id])
      @students = @assignment.remove_student_keys(parse_array(params[:keys]))
      @assignment.save
    end
  end
  
  def submit
    @assignment = Assignment.find_by_id(params[:id])
    @student = @assignment.students.find_by_key(params[:student_key])
    if(@student != nil)    
      submission = get_file_contents(params[:submission])
      @submission = @student.add_submission(submission)
      @student.save()
      @submission_successful = true
    else
      @submission_successful = false
    end
  end
  
  def retrieve_submissions
    @assignment = Assignment.find_by_id(params[:id])
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
end
