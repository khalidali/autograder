class AssignmentsController < ApplicationController
  before_filter :authenticate_instructor, :only => [:create]
  prepend_before_filter :find_assignment, :except => [:create]
  before_filter :authenticate_instructor_with_assignment, :except => [:create, :submit]
  
  def create 
    due_date = params[:due_date].to_time unless params[:due_date] == nil or is_valid_date?(params[:due_date])  
    hard_deadline = params[:hard_deadline].to_time unless params[:hard_deadline] == nil or is_valid_date?(params[:hard_deadline])         
    autograder = get_file_contents(params[:autograder]) unless params[:autograder] == nil
    grading_strategy = params[:grading_strategy] if is_grading_strategy?(params[:grading_strategy])
    
    @assignment = Assignment.create(:name => params[:name],
                                    :due_date => due_date, 
                                    :hard_deadline => hard_deadline,
                                    :grading_strategy => grading_strategy,
                                    :autograder => autograder,
                                    :submissions_limit => params[:submissions_limit])
                       
    if(params[:student_keys] != nil)
       student_keys = parse_array(params[:student_keys])
       @added_student_keys, @rejected_student_keys = @assignment.add_student_keys(student_keys)
    end
         
    @assignment.save()
    @instructor.assignments << @assignment 
    
    @instructor.save()
  end
  
  def show
  end
  
  def get_name
  end
  
  def set_name
    @assignment.name = params[:name]
    @assignment.save
  end
  
  def get_autograder
  end
  
  def set_autograder
    if not params[:autograder]
      render :text => 'ERROR: required param \'autograder\' missing.'
    else
      @assignment.autograder = get_file_contents(params[:autograder])
      @assignment.save
    end
  end
  
  def get_due_date
  end
  
  def set_due_date
    due_date = params[:due_date].to_time unless params[:due_date] == nil or not is_valid_date?(params[:due_date])
    if(due_date != nil)
      @assignment.due_date = due_date
      @assignment.save
    else
      render :text => 'ERROR: invalid or missing param \'due_date\'.'
    end
  end
  
  def get_hard_deadline
  end
  
  def set_hard_deadline
    hard_deadline = params[:hard_deadline].to_time unless params[:hard_deadline] == nil or is_valid_date?(params[:hard_deadline]) 
    if(hard_deadline != nil)
      @assignment.hard_deadline = hard_deadline
      @assignment.save
    else
      render :text => 'ERROR: invalid or missing param \'hard_deadline\'.'
    end
  end
  
  def get_submissions_limit
  end
  
  def get_grading_strategy
  end
  
  def set_grading_strategy
    if not @assignment.grading_strategies.include? params[:grading_strategy] then
      render :text => 'ERROR: invalid grading strategy passed in.'
    else
      @assignment.grading_strategy = params[:grading_strategy]
      @assignment.save
    end
  end
  
  def set_submissions_limit
    @assignment.submissions_limit = params[:submissions_limit]
    @assignment.save
  end
  
  def list_student_keys
      @students = @assignment.students
  end
  
  def add_student_keys
    if not params[:keys] then
      render :text => 'ERROR: required param \'keys\' missing.'
    else
      @students = @assignment.add_student_keys(parse_array(params[:keys]))
      @assignment.save
    end
  end
  
  def remove_student_keys
    if not params[:keys] then
      render :text => 'ERROR: required param \'keys\' missing.'
    else
      @students = @assignment.remove_student_keys(parse_array(params[:keys]))
      @assignment.save
    end
  end
  
  def submit
    @student = @assignment.students.find_by_key params[:key]
    if not @student and not params[:submission] 
      render :text => 'ERROR: student key doesn\'t exist and required param \'submission\' missing.'
    elsif not @student then
      render :text => 'ERROR: student key doesn\'t exist.'
    elsif not params[:submission] then
      render :text => 'ERROR: required param \'submission\' missing.'
    elsif @assignment.submissions_limit > 0 and @student.submissions.count == @assignment.submissions_limit
      render :text => 'ERROR: submissions limit reached.'
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
  
  def authenticate_instructor 
    @instructor = is_instructor? params[:inst_key]
    if not @instructor
      render :text => 'ERROR: professor key is not valid'
    end
  end
  
  def authenticate_instructor_with_assignment
    @instructor = is_instructor? params[:inst_key]
    if not (@instructor and @assignment.instructor == @instructor)
      render :text => 'ERROR: professor key is not valid for this assignment'
    end
  end
  
  def find_assignment
    @assignment = is_assignment? params[:id]

    if not @assignment then
      render :text => 'ERROR: assignment does not exist' 
    end 
  end 
end
