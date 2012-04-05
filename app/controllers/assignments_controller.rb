class AssignmentsController < ApplicationController

  respond_to :json
  
  def create 
    @assignment = Assignment.create(:prof_key => params[:prof_key], :due_date => params[:due_date])
    if(params[:student_keys] != nil)
       student_keys = params[:student_keys][1..-2].split(',').each{|e| e.strip!}
       @assignment.add_student_keys(student_keys)
  	   @assignment.save
    end
  end

  def add_student_keys
    @assignment = Assignment.find_by_id(params[:id])
    if(params[:student_keys] != nil)
       @student_keys = params[:student_keys][1..-2].split(',').each{|e| e.strip!}
       @assignment.add_student_keys(@student_keys)
	   @assignment.save
    end
  end
  
  def remove_student_keys
    @assignment = Assignment.find_by_id(params[:id])

    if(params[:student_keys] != nil)
       @student_keys = params[:student_keys][1..-2].split(',').each{|e| e.strip!}
       @assignment.remove_student_keys(@student_keys)
	   @assignment.save
    end
  end
  
  def change_due_date
    @assignment = Assignment.find_by_id(params[:id])
    if(params[:due_date] != nil)
      @assignment.change_due_date(params[:due_date])
      @assignment.save
    end 
  end
  
  def submit
    @assignment = Assignment.find_by_id(params[:id])
    #if(@assignment.students.any? {|std| std.student_key == params[:student_key]})
    if(@assignment.students.find_all_by_student_key(params[:student_key]).any?)
      @student = @assignment.students.find_by_student_key(params[:student_key])
      @student.add_submission(params[:submission])
      @student.save()
      render :submit_successful 
    else
      render :submit_fail
    end
  end
  
  def retrieve_submissions_by_status
    @assignment = Assignment.find_by_id(params[:id])
    @submissions = @assignment.submissions.find_all_by_status(params[:status])
  end

  def retrieve_all_submissions
    @assignment = Assignment.find_by_id(params[:id])
    @submissions = @assignment.submissions
  end
  
  def retrieve_submission_by_student_key
    @assignment = Assignment.find_by_id(params[:id])
    if(@assignment.students.any? {|std| std.student_key == params[:student_key]})
      @submissions = @assignment.students.find_by_student_key(params[:student_key]).submissions 
      render :retrieve_submission_by_student_key_successful 
    else
      render :invalid_student_key
    end    
  end
end
