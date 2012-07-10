module CalendarHelper
  include LaterDude::CalendarHelper
  require 'builder'

  def calendar_display(params)
    month = params[:month] ? params[:month].to_i : Date.today.month
    year = params[:year] ? params[:year].to_i : Date.today.year

    events_this_month = Event.by_month_and_year(month, year)
    calendar_for(year, month, :first_day_of_week => 1) do |day|
      events = events_this_month.select {|event| event.start_date.to_date == day}
      if !events.empty?
        [calendar_item(day, events), {:class => 'calendar_day_with_events'}]
        render 'calendar/day_with_events', :day => day, :events => events
      else
        [content_tag(:div, day.day, :class => 'calendar_day_marker'), {:class => 'calendar_day_without_events'}]
      end
    end
  end

  def calendar_item(day, events)
    xml = Builder::XmlMarkup.new
      xml.div :class => 'calendar_event_day' do
        xml.div day.day, :class => 'calendar_day_marker'
        events.each do |event|
          xml.div :class => 'calendar_event' do
            xml.div("#{event.start_time.strftime('%H:%M')}: ", "class" => "event_time")
            xml.a(event.title, "href" => host_event_path(event))
          end
        end
      end
  end

  def other_month_link(state, page)
    month = params[:month] ? params[:month].to_i : Date.today.month
    year = params[:year] ? params[:year].to_i : Date.today.year

    date = Date.new(year,month,1)
    other_month = state == 'previous' ? date - 1.month : date + 1.month

    link_to other_month.strftime('%b'), host_page_path(page, :month => other_month.month, :year => other_month.year), :class => 'calendar_other_month_link', :id => "calendar_other_month_link_#{state}"
  end

  def date_icon(date)
    xml = Builder::XmlMarkup.new
    xml.div :class => 'date_icon' do
      xml.div date.strftime('%b'), :class => 'date_icon_month'
      xml.div date.day, :class => 'date_icon_day'
    end
  end
  
end