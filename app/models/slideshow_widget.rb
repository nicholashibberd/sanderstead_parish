class SlideshowWidget < Widget
  has_and_belongs_to_many :slide_widgets
  
  field :thumbnail_width, :default => 140

  def first_slide
  	@image ||= self.slide_widgets.asc(:position).first
  end

  def remaining_slides
  	slides = self.slide_widgets.asc(:position)[1..-1]
  end
end