module WidgetsHelper
  def path_for_widget(page, widget)
    widget.new_record? ? page_widgets_path(@church, page) : page_widget_path(@church, page, widget)
  end
  
end