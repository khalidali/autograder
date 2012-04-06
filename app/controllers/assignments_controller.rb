class AssignmentsController < ApplicationController

  respond_to :json
  
  def create 
    @assignment = Assignment.create(:prof_key => params[:prof_key], :due_date => params[:due_date])
    if(params[:student_keys] != nil)
       student_keys = params[:student_keys][1..-2].split(',').each{|e| e.strip!}
       @assignment.add_student_keys(student_keys)
  	   @assignment.save
    end
    #render "create.json.rabl"
  end

  def add_student_keys
    @assignment = Assignment.find_by_id(params[:id])
    if(params[:student_keys] != nil)
       @student_keys = params[:student_keys][1..-2].split(',').each{|e| e.strip!}
       @assignment.add_student_keys(@student_keys)
	   @assignment.save
    end
    #render "add_student_keys.json.rabl"
  end
  
  def remove_student_keys
    @assignment = Assignment.find_by_id(params[:id])

    if(params[:student_keys] != nil)
       @student_keys = params[:student_keys][1..-2].split(',').each{|e| e.strip!}
       @assignment.remove_student_keys(@student_keys)
	   @assignment.save
    end
    #render "remove_student_keys.json.rabl"
  end
  
  def change_due_date
    @assignment = Assignment.find_by_id(params[:id])
    if(params[:due_date] != nil)
      @assignment.change_due_date(params[:due_date])
      @assignment.save
    end 
    #render "change_due_date.json.rabl"
  end
  
  def submit
    @assignment = Assignment.find_by_id(params[:id])
    
    if(@assignment.students.find_all_by_student_key(params[:student_key]).any?)
      @student = @assignment.students.find_by_student_key(params[:student_key])
      @student.add_submission(params[:submission])
      @student.save()
      @submission_successful = true
    else
      @submission_successful = true
    end
  end
  
  def retrieve_submissions_by_status
    @assignment = Assignment.find_by_id(params[:id])
    @submissions = @assignment.submissions.find_all_by_status(params[:status])
    #render "retrieve_submissions_by_status.json.rabl" 
  end

  def retrieve_all_submissions
    @assignment = Assignment.find_by_id(params[:id])
    @submissions = @assignment.submissions
    #render "retrieve_all_submissions.json.rabl" 
  end
  
  def retrieve_submission_by_student_key
    @assignment = Assignment.find_by_id(params[:id])
    if(@assignment.students.find_all_by_student_key(params[:student_key]).any?)
      @submissions = @assignment.students.find_by_student_key(params[:student_key]).submissions 
      @student_key_valid = true
      #render :retrieve_submission_by_student_key_successful
    else
      @student_key_valid = false
      #render :invalid_student_key
    end    
  end
end
