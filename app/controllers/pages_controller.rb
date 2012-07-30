class PagesController < AdminController
  skip_before_filter :login_required, :only => [:show, :home]
  layout :choose_layout
  
  def home
    @page = Site.instance.homepage
    render 'show'
  end
  
  def show
    @page = @church.pages.find_by_slug(params[:id])
  end
  
  def new
    @page = Page.new
  end

  def edit
    @page = @church.pages.find_by_slug(params[:id])
  end

  def index
    @pages = @church.pages.all
  end
  
  def all_pages
    @churches = Church.all
  end

  def create
    page = Page.new(params[:page])
    if page.save
  		redirect_to edit_page_path(@church, page), :notice => 'Page successfully created'
    else
      flash[:error] = "There was an error creating the page"
      render :action => 'new'
    end  		
  end

	def	update
		page = @church.pages.find_by_slug(params[:id])
    page.update_page(params[:page])
		redirect_to pages_path(@church)
	end

	def	destroy
		page = @church.pages.find_by_slug(params[:id])
		page.destroy
    flash[:error] = "Page successfully deleted"  		
		redirect_to pages_path(@church)
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
    redirect_to new_page_widget_path(@church, page, :widget_type => "#{widget_type}_widget", :region => region, :repeating => params[:repeating])
  end
  
  def choose_layout
    request[:action] == 'show' ? 'application' : 'admin'
  end
  
end