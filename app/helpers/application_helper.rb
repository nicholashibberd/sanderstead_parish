module ApplicationHelper
  def logo
    if @page && @page.group
      link_to image_tag("/assets/#{@page.group.slug}-logo.png"), root_path
    else
      link_to image_tag("parish-logo.png"), root_path
    end
  end
  
  def sub_logo
    if @page && @page.group
      link_to image_tag("parish-logo-small.png"), root_path
    end
  end
  
end
