class Image
  include Mongoid::Document
  #attr_accessible :file, :file_cache, :name, :caption, :link, :image_type
  
  #field :cover_image_uid
  field :name
  field :caption
  field :link
  field :image_type
  field :test_field
  
  has_and_belongs_to_many :pages
  has_many :image_widgets
  validates_presence_of :name
  validates_uniqueness_of :name
  
  mount_uploader :file, ImageUploader
  
  before_destroy :remember_id
  after_destroy :remove_id_directory
  
  scope :background_images, where(:image_type => 'background_image')
  scope :content, where(:image_type => 'content')
  
  protected

  def remember_id
    @id = id
  end

  def remove_id_directory
    FileUtils.remove_dir("#{Rails.root}/public/uploads/image/file/#{@id}", :force => true)
  end
  
end
