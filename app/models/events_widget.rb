class EventsWidget < Widget
  field :name
  field :event_category
  field :number_to_display, :type => Integer, :default => 5
  field :church_id, :default => 'parish'
  
  def events_by_date
    events = church_id == 'parish' ? Event.all : Event.by_church(church_id)
    events_by_category = event_category == 'All' ? events.upcoming : events.upcoming.by_category(event_category)
    upcoming_events = events_by_category.limit(number_to_display).asc(:date)
    upcoming_events.group_by {|event| event.start_date}
  end  

  def events
    events = Event.upcoming
    unless event_category == 'All'
      events = events.by_category(event_category) if event_category
    end
    unless church_id == 'parish'
      events = events.by_church(church_id) if church_id
    end
    events.group_by {|event| event.start_date}.first(number_to_display)
  end  
  
end