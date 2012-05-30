module Cms
  class NoticesController < Cms::AdminController
  
    def index
      @notices = Notice.by_group_and_month(@group, params[:month])
    end
  
    def edit
      @notice = Notice.find(params[:id])
      @path = main_app.cms_notice_path(@group, @notice)
    end
  
    def new
      @notice = Notice.new
      @path = main_app.cms_notices_path(@group)
    end

    def create
      @notice = Notice.new(params[:notice])
      if @notice.save
        redirect_to(main_app.cms_notices_path(@group), :notice => "Notice was successfully created")
      else
        flash[:error] = "There was an error creating the notice"
        render :action => "new"
      end
    end

    def update
      @notice = Notice.find(params[:id])
      if @notice.update_attributes(params[:notice])
        redirect_to(main_app.cms_notices_path(@group), :notice => "Notice was successfully updated")
      else
        flash[:error] = "There was an error updating the notice"
        render :action => "edit"
      end
    end

    def destroy
      notice = Notice.find(params[:id])
      notice.destroy
      redirect_to main_app.cms_notices_path(@group)
    end
  
    def choose_layout
    
    end
  end
end