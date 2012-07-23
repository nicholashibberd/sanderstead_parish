class NavMenu
  include Mongoid::Document
  field :name
  field :menu_type
  field :slug
  
  has_many :nav_items
  #test
  
  validates_uniqueness_of :name
  before_create :generate_slug
  
  def generate_slug
    self.slug = name.gsub("'", "").parameterize('_')
  end

  def self.find_by_slug(slug)
    self.where(:slug => slug).first
  end  
  
  def order_nav_items(params)
    nav_items.each do |nav_item|
      nav_item.position = params['navitem'].index(nav_item.id.to_s) + 1
      nav_item.save!
    end
  end
  
  def max_position
    existing_nav_items = nav_items.select {|nav_item| !nav_item.position.nil?}
    current_highest = existing_nav_items.map(&:position).max
    current_highest ||= 0
  end  
  
  def self.admin_nav
    where(:menu_type => 'admin').first
  end

  def self.main_nav
    where(:menu_type => 'main_nav').first
  end
    
end
