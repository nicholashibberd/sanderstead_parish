class Widget
  include Mongoid::Document
  field :position, :type => Integer, :default => 1000
  field :region
  field :repeating, :type => Boolean, :default => false
  
  
  default_scope asc(:position)
  
  belongs_to :page
  
  scope :by_region, lambda {|region| where(:region => region)}
  scope :by_type, lambda {|type| where(:_type => type)}
  scope :repeating, where(:repeating => true)
  
  def widget_type
    self._type.underscore
  end
  
  def update_widget(params)
    self.update_attributes(params[widget_type])
  end

end
