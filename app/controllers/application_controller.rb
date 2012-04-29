class ApplicationController < ActionController::Base
  protect_from_forgery
  respond_to :json
  
  private
  
  def parse_array(array)
    array[1..-2].split(',').each { |e| e.strip! }
  end
  
end
