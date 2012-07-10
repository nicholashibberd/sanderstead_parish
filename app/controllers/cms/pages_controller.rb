module Cms
  class PagesController < Cms::AdminController

    def new
      @page = Page.new
    end

    def edit
      @page = Page.find_by_slug(params[:id])
    end

    def show 
      @page = Page.find_by_slug(params[:id])
    end

    def index
      @pages = @church.pages.all
      render 'index', :locals => {:new_page_path => main_app.new_cms_page_path(@church)}
    end

    def create
      page = Page.new(params[:page])
      if page.save
    		redirect_to edit_page_path(page), :notice => 'Page successfully created'
      else
        flash[:error] = "There was an error creating the page"
        render :action => 'new'
      end  		
    end

  	def	update
  		page = Page.find_by_slug(params[:id])
      page.update_page(params[:page])
  		redirect_to main_app.cms_pages_path(@church)
  	end

  	def	destroy
  		page = Page.find_by_slug(params[:id])
  		church = Church.find_by_slug(page.church_id)
  		page.destroy
      flash[:error] = "Page successfully deleted"  		
  		redirect_to main_app.cms_pages_path(@church)
  	end   
  	
  	def order_widgets
  		page = Page.find(params[:page_id])
  		page.order_widgets(params)
  		render :nothing => true
    end
     
    def add_region
      page = Page.find(params[:page_id])
      widget_type = params[:commit].downcase
      region = params[:region].parameterize('_')
      redirect_to new_page_widget_path(page, :widget_type => "#{widget_type}_widget", :region => region, :repeating => params[:repeating])
    end
  end
end
