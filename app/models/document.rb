class Document
  include Mongoid::Document

  field :name

  mount_uploader :file, DocumentUploader
  
  before_destroy :remember_id
  after_destroy :remove_id_directory
  
  protected

  def remember_id
    @id = id
  end

  def remove_id_directory
    FileUtils.remove_dir("#{Rails.root}/public/uploads/document/file/#{@id}", :force => true)
  end
  
end
