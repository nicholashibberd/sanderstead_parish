class NoticesController < ApplicationController
  
  def index
    @group = Group.find_by_slug(params[:group_id])
    @notices = Notice.all
  end
  
  def show
    @group = Group.find_by_slug(params[:group_id])    
    @notice = Notice.find(params[:id])
  end

end