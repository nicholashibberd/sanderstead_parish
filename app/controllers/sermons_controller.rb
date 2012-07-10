class SermonsController < ApplicationController
  
  def index
    @sermons = Sermon.all
  end
  
  def show
    @sermon = Sermon.find(params[:id])
  end

end