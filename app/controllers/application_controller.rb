class ApplicationController < ActionController::Base
  helper Cms::Engine.helpers  
  protect_from_forgery
  
  before_filter :set_church
  
  def set_church
    @church = Church.find_by_slug(params[:group_id]) || Parish.instance
  end
  
end
