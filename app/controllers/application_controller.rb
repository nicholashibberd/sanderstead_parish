class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :set_church
  
  def set_church
    @church = Church.find_by_slug(params[:church_id]) || Parish.instance
  end
  
end
