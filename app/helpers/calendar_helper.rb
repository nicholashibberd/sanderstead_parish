module CalendarHelper
  def render_calendar
    #date = params[:date] ? Date.parse(params[:date].join('-01') : Date.today
    date = params[:date] ? Date.parse(params[:date]) : Date.today
    capture(Calendar.new(date), &proc)
  end
  
  def date_icon(date)
    s = ""
    s << "<div class='date_icon'>"
    s <<  "<div class='date_icon_month'>#{date.strftime('%b')}</div>"
    s <<  "<div class='date_icon_day'>#{date.day}</div>"
    s << "</div>"
		s.html_safe
  end
  
  
  class Calendar
    attr_accessor :date

    def initialize(date)
      @date = date
      @year = date.year
      @month = date.month
      @days_with_events = days_with_events
      @events_by_day = events_by_day
    end
    
    def first_day
      Date.civil(@year, (@month))
    end

    def last_day
      Date.civil(@year, (@month), -1)
    end
    
    def previous_month
      @date - 1.month
    end
    
    def next_month
      @date + 1.month
    end
    
    def month(which)
      case which
        when 'current' then @date.strftime('%B %Y')
        when 'previous' then previous_month.strftime('%B %Y')
        when 'next' then next_month.strftime('%B %Y')
      end
    end
    
    def days
      first_day..last_day
    end
    
    def events
      Event.by_month_and_year(@month, @year)
    end
    
    def events_by_church
      by_church = events.group_by  {|event| event.church_id}
    end
    
    def days_with_events
      by_day = events.group_by {|event| event.start_time.day}
      hash = {}
      by_day.each do |day, day_events|
        hash[day] = day_events.group_by {|event| event.church_id}
      end
      hash
    end
    
    def events_by_day
      hash = {}
      days.each do |day|
        hash[day] = @days_with_events[day.day]
      end
      hash
    end
    
    def events_today?(day)
      @events_by_day[day] ? "day_with_events" : "day_without_events"
    end
    
  end
end