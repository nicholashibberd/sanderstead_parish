class Article
  include Mongoid::Document
  default_scope desc(:date)
  
  field :title
  field :content
  field :date, :type => Date, :default => Date.today
  field :group_id
  
  scope :by_church, lambda { |group_id| where(:group_id => group_id)}
  
  def self.by_church_and_month(group, month)
    sermons = self.all
    sermons = sermons.by_group(group.id) if group
    sermons = sermons.select {|a| a.date.strftime('%m-%Y') == month} if month
    sermons
  end
  
  def self.months_with_articles(group)
    articles = by_church_and_month(group, nil)
    dates = articles.map(&:date)
    dates.map {|date| date.to_date.at_beginning_of_month}.uniq    
  end
  
end