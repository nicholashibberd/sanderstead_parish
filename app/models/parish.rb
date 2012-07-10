class Parish < Church
  include Mongoid::Document
  
  field :name, :default => 'Parish'
  
  # Class methods
  class << self

    # We can only get the homepage object by calling Homepage.instance
    def instance
      first || create!
    end
    
    private :new

  end
end