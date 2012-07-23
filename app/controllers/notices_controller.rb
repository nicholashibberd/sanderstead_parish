class NoticesController < ApplicationController
  layout :choose_layout
  
  def index    
    @notices = Notice.by_church_and_month(@church, params[:month])    
  end
  
  def show
    @notice = Notice.find(params[:id])
  end
  
  def admin_index    
    @notices = Notice.by_church_and_month(@church, params[:month])
  end

  def edit
    @notice = Notice.find(params[:id])
    @path = admin_notice_path(@church, @notice)
  end

  def new
    @notice = Notice.new
    @path = admin_notices_path(@church)
  end

  def create
    @notice = Notice.new(params[:notice])
    if @notice.save
      redirect_to(admin_notices_path(@church), :notice => "Notice was successfully created")
    else
      flash[:error] = "There was an error creating the notice"
      render :action => "new"
    end
  end

  def update
    @notice = Notice.find(params[:id])
    if @notice.update_attributes(params[:notice])
      redirect_to(admin_notices_path(@church), :notice => "Notice was successfully updated")
    else
      flash[:error] = "There was an error updating the notice"
      render :action => "edit"
    end
  end

  def destroy
    notice = Notice.find(params[:id])
    notice.destroy
    redirect_to admin_notices_path(@church)
  end

  def choose_layout
    ['show', 'index'].include?(request[:action]) ? 'application' : 'admin'
  end
  
end