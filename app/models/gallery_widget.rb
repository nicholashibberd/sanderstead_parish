class GalleryWidget < Widget
  has_and_belongs_to_many :images
  
  field :thumbnail_width, :default => 140
  
end