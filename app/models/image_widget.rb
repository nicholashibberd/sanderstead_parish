class ImageWidget < Widget
  belongs_to :image
  
  field :caption
  field :display_in_lightbox, :default => false, :type => Boolean
  field :link
  
end