class EventsController < ApplicationController
  def index
    @events = Event.all
    @event_categories = Event.order('category asc').uniq.pluck(:category);
    @event_provinces = Location.joins(:events).pluck(:province).uniq
  end

  def category
    @events = Event.where(category: params[:category]).order('start_at desc')
    @event_categories = Event.where.not(category: params[:category]).uniq.pluck(:category)
    @event_provinces = Location.joins(:events).pluck(:province).uniq
    render :index
  end

  def location
    location = Location.find_by(province: params[:location])
    @events = location.events.order('start_at desc')
    @event_provinces = Location.joins(:events).pluck(:province).uniq
    @event_categories = Event.uniq.pluck(:category)
    render :index
  end
end
