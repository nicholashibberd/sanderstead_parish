class Church
  include Mongoid::Document
  
  field :name
  field :slug
  
  #has_many :event_series
  #has_many :notices
  #has_many :sermons
  
  validates_uniqueness_of :name
  before_create :generate_slug
  
  def generate_slug
    self.slug = name.gsub("'", "").parameterize
  end

  def to_param
    slug
  end
  
  def self.find_by_slug(slug)
    self.where(:slug => slug).first
  end
  
  def homepage
    homepage_id ? Page.find(homepage_id) : pages.first
  end
  
  def events
    Event.by_church(slug)
  end
  
  def pages
    Page.by_church(slug)
  end
  
  def sermons
    Sermon.by_church(slug)
  end
  
  def notices
    Notice.by_church(slug)
  end
    
end
