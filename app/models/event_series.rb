class EventSeries
  include Mongoid::Document
  include Mongoid::MultiParameterAttributes
  
  has_many :events, :dependent => :destroy
  belongs_to :church
  
  field :title
  field :location
  field :start_time, :type => DateTime
  field :end_time, :type => DateTime
  field :summary
  field :content
  field :description
  field :all_day
  field :period
  field :frequency
  field :position
  field :series_id
  field :category  
  field :event_series_id  
  
  validates_presence_of :frequency
  validates_presence_of :period
  validates_presence_of :start_time
  validates_presence_of :end_time
  
  after_create :create_events
      
  def new_datetime(date)
    DateTime.new(date.year, date.month, date.day, start_time.hour, start_time.min, start_time.sec)
  end
  
  def create_events
    days = recurrence_period(period).is_a?(Integer) ? repeating_days_every_month : repeating_days_at_regular_intervals
    days.each do |day|
      st = DateTime.parse("#{start_time.hour}:#{start_time.min}:#{start_time.sec}, #{day.day}-#{day.month}-#{day.year}")
      self.events.create(:title => title, :description => description, :all_day => all_day, :start_time => st, :category => category, :group_id => group_id, :location => location)
    end
  end

  def repeating_days_at_regular_intervals
    st = start_time
    et = end_time
    p = recurrence_period(period)
    nst, net = st, et
    array = []
    while frequency.to_i.send(p).from_now(st) <= end_time
      #self.events.create(:title => title, :description => description, :all_day => all_day, :start_time => nst, :end_time => net, :category => category, :institution_id => institution_id, :location => location)
      array << st
      nst = st = frequency.to_i.send(p).from_now(st)
      net = et = frequency.to_i.send(p).from_now(et)
      if period.downcase == 'monthly' or period.downcase == 'yearly'
        begin 
          nst = DateTime.parse("#{start_time.hour}:#{start_time.min}:#{start_time.sec}, #{start_time.day}-#{st.month}-#{st.year}")  
          net = DateTime.parse("#{end_time.hour}:#{end_time.min}:#{end_time.sec}, #{end_time.day}-#{et.month}-#{et.year}")
        rescue
          nst = net = nil
        end
      end
    end
    array
  end

  def repeating_days_every_month
    weekday = recurrence_period(period)
    months = EventSeries.months_between(start_time, end_time)
    weekdays = []
    months.each do |month_start, month_end| 
      month_range = (month_start..month_end)
      specific_days = month_range.select {|day| day.wday == weekday}
      weekdays << specific_days
    end
    weekdays_by_position = weekdays.map {|days_in_month| days_in_month[position.to_i]}
    weekdays_by_position.compact.select {|weekday| weekday >= start_time && weekday <= end_time}    
  end  

  def recurrence_period(period)
    parsed_period = case period
      when 'Daily' then 'days'
      when "Weekly" then 'weeks'
      when "Monthly" then 'months'
      when "Yearly" then 'years'
      when "Monday" then 1
      when "Tuesday" then 2
      when "Wednesdy" then 3
      when "Thursday" then 4
      when "Friday" then 5
      when "Saturday" then 6
      when "Sunday" then 7
    end
    return parsed_period
  end
  
  def self.months_between(d1, d2)
    months = []
    start_date = Date.civil(d1.year, d1.month, 1)
    end_date = Date.civil(d2.year, d2.month, 1)

    raise ArgumentError unless d1 <= d2

    while (start_date < end_date)
      last_day_of_start_date_month = Date.civil(start_date.year, start_date.month, -1)      
      months << [start_date, last_day_of_start_date_month]
      start_date = start_date >>1
    end

    months << [end_date, end_date]

  end
  
  
  
end