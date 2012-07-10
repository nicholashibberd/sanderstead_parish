module Cms
  class SermonsController < Cms::AdminController
    #layout 'application'
  
    def index
      @sermons = Sermon.by_church_and_month(@group, params[:month])
    end
  
    def edit
      @sermon = Sermon.find(params[:id])
      @path = main_app.cms_sermon_path(@group, @sermon)
    end
  
    def new
      @sermon = Sermon.new
      @path = main_app.cms_sermons_path(@group)
    end

    def create
      @sermon = Sermon.new(params[:sermon])
      if @sermon.save
        redirect_to(main_app.cms_sermons_path(@group), :notice => "Sermon was successfully created")
      else
        flash[:error] = "There was an error creating the sermon"
        render :action => "new"
      end
    end

    def update
      @sermon = Sermon.find(params[:id])
      if @sermon.update_attributes(params[:sermon])
        redirect_to(main_app.cms_sermons_path(@group), :notice => "Sermon was successfully updated")
      else
        flash[:error] = "There was an error updating the sermon"
        render :action => "edit"
      end
    end

    def destroy
      sermon = Sermon.find(params[:id])
      sermon.destroy
      redirect_to main_app.cms_sermons_path(@group)
    end
  
    def choose_layout
    
    end
  end
end