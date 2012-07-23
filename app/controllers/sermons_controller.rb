class SermonsController < ApplicationController
  layout :choose_layout
  
  def index
    @sermons = Sermon.by_church_and_month(@church, params[:month])    
  end
  
  def show
    @sermon = Sermon.find(params[:id])
  end
  
  def admin_index    
    @sermons = Sermon.by_church_and_month(@church, params[:month])
  end

  def edit
    @sermon = Sermon.find(params[:id])
    @path = admin_sermon_path(@church, @sermon)
  end

  def new
    @sermon = Sermon.new
    @path = admin_sermons_path(@church)
  end

  def create
    @sermon = Sermon.new(params[:sermon])
    if @sermon.save
      redirect_to(admin_sermons_path(@church), :notice => "Sermon was successfully created")
    else
      flash[:error] = "There was an error creating the sermon"
      render :action => "new"
    end
  end

  def update  
    @sermon = Sermon.find(params[:id])
    if @sermon.update_attributes(params[:sermon])
      redirect_to(admin_sermons_path(@church), :notice => "Sermon was successfully updated")
    else
      flash[:error] = "There was an error updating the sermon"
      render :action => "edit"
    end
  end

  def destroy
    sermon = Sermon.find(params[:id])
    sermon.destroy
    redirect_to admin_sermons_path(@church)
  end

  def choose_layout
    ['show', 'index'].include?(request[:action]) ? 'application' : 'admin'
  end
  
end