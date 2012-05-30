module ApplicationHelper
  def logo
    if @group
    #if @page && @page.group
      link_to image_tag("/assets/#{@group.slug}-logo.png"), root_path
    else
      link_to image_tag("parish-logo.png"), root_path
    end
  end
  
  def sub_logo
    if @group
      link_to image_tag("parish-logo-small.png"), root_path
    end
  end
  
end
