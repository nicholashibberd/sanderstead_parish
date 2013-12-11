class SlideshowWidget < Widget
  has_and_belongs_to_many :images
  
  field :thumbnail_width, :default => 140

  def first_image
  	@image ||= self.images.asc(:position).first
  end

  def remaining_images
  	images = self.images.asc(:position)[1..-1]
  end
end