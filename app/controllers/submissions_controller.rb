class SubmissionsController < ApplicationController

  def update_status
    @submission = Submission.find_by_id(params[:id])
    @submission.output = params[:output].tempfile.path
    @submission.status = "complete"
    @submission.save
  
  end
end
