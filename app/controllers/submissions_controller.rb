class SubmissionsController < ApplicationController
  def update_status
    @submission = Submission.find_by_id(params[:id])
    @submission.output = File.open(params[:output].tempfile.path, "rb").read() 
    @submission.status = params[:status] 
    @submission.save
  end
end
