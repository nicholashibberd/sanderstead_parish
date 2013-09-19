module Article
  def self.by_church_and_month(church, month)
    sermons = self.all
    sermons = sermons.by_group(church.id) if church
    sermons = sermons.select {|a| a.date.strftime('%m-%Y') == month} if month
    sermons
  end

  def self.months_with_articles(church)
    articles = by_church_and_month(church, nil)
    dates = articles.map(&:date)
    dates.map {|date| date.to_date.at_beginning_of_month}.uniq    
  end
end