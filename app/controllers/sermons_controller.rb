class SermonsController < ApplicationController
  
  def index
    @group = Group.find_by_slug(params[:group_id])
    @sermons = Sermon.all
  end
  
  def show
    @group = Group.find_by_slug(params[:group_id])    
    @sermon = Sermon.find(params[:id])
  end

end