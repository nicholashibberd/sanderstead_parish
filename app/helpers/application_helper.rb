module ApplicationHelper
  def logo
    if @church
      link_to image_tag("/assets/#{@church.slug}-logo.png"), root_path
    else
      link_to image_tag("parish-logo.png"), root_path
    end
  end
  
  def sub_logo
    if @group
      link_to image_tag("parish-logo-small.png"), root_path
    end
  end
  
  def church_nav
    if request.path.include?('all-saints')
      slug = 'all_saints_main_navigation'
    elsif request.path.include?('st-marys')
      slug = 'st_marys_main_navigation'
    elsif request.path.include?('st-antonys')
      slug = 'st_antonys_main_navigation'
    elsif request.path.include?('st-edmunds')
      slug = 'st_edmunds_main_navigation'
    else
      slug = 'parish_main_navigation'
    end
    NavMenu.find_by_slug(slug) rescue NavMenu.first
  end  
  
  def current_controller
    request[:controller].gsub('cms/', '')
  end
  
  def show_editing_tools?
    request[:action] == 'edit'
  end
  
  def layouts
    dir = Dir.new(Rails.root.join("app", "assets", "images", "layouts")) rescue nil
    file_names = dir.entries
    file_names.delete_if { |file_name| [".", "..", ".DS_Store"].include?(file_name)  }
    file_names.map {|file_name| file_name.chomp(File.extname(file_name)) }
  end
  
  def groups?
    Site.instance.has_groups
  end
  
  def host_page_path(page)
    "/pages/#{page.slug}"
  end
  
  
  def region(region, &proc)
    name = region.is_a?(Hash) ? region[:name] : region
    options = region.is_a?(Hash) ? region.except(:name) : {}
    controller.action_name == 'edit' ? edit_region(name, options, &proc) : show_region(name, options, &proc)
  end
  
  def show_region(name, options, &proc)
    region_builder = Region.new(name, @page, options, self) 
    if block_given?
      capture(region_builder, &proc)
    else
      region_builder.all
    end        
  end
  
  def edit_region(name, options, &proc)
    region_builder = Region.new(name, @page, options, self) 
    if block_given?
      render_region(name, capture(region_builder, &proc))
    else
      render_region(name, region_builder.all)
    end    
  end
  
  def render_region(name, html)
    output = tag(:div, :class => 'admin_region', :id => name)
    output.safe_concat("<h2>#{name.titleize}</h2>")
    output << html
    output.safe_concat('</div>')
    output    
  end
  
  def render_widgets(name, widgets, widget_types)
    render "pages/#{controller.action_name}_widgets", :region => name, :widgets => widgets, :widget_types => widget_types
  end
  
  def repeating_regions(&block)
    output = tag(:div, :id => 'repeating_regions')
    output << capture(@page.repeating_regions, &block)
    output << add_region if controller.action_name == 'edit'
    output.safe_concat('</div>')
    output
  end
  
  def add_region
    render 'pages/add_region', :repeating => true
  end
  
  class Region
    attr_accessor :name, :template, :options, :page

    def initialize(name, page, options, template)
      @name = name
      @page = page
      @options = options
      @template = template
    end
    
    def images
      render(name, widgets(:widget_type => 'ImageWidget'), ['image'])
    end

    def text
      render(name, widgets(:widget_type => 'TextWidget'), ['text'])
    end
    
    def map
      render(name, widgets(:widget_type => 'MapWidget'), ['map'])
    end
    
    def gallery
      render(name, widgets(:widget_type => 'GalleryWidget'), ['gallery'])
    end
    
    def all
      #template.render_widgets(name, widgets, ['text', 'image'])
      widget_types = @options[:widget_types] || ['text', 'image', 'gallery', 'events', 'map']
      render(name, widgets, widget_types)
    end   
    
    def render(name, widgets, widget_types)
      template.render_widgets(name, widgets, widget_types)
    end
    
    def widgets(options = {})
      widgets = page.widgets.by_region(name)
      widgets = widgets.by_type(options[:widget_type]) if options[:widget_type]
      widgets
    end
      
  end  
  
end
