class EventsWidget < Widget
  field :name
  field :event_category
  field :number_to_display, :type => Integer, :default => 5
  field :group_id
  
  def events_by_date
    events = group_id ? events.by_church(group_id) : Event.all
    events_by_category = event_category == 'All' ? events.upcoming : events.upcoming.by_category(event_category)
    upcoming_events = events_by_category.limit(number_to_display).asc(:date)
    upcoming_events.group_by {|event| event.start_date}
  end  
  
end