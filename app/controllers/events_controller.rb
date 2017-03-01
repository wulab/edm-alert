class EventsController < ApplicationController
  def index
    @events = Event.order(start_at: :desc).page(params[:page]).this_weeks
    @event_categories = Event.categories.keys
    @event_provinces = Location.joins(:events).pluck(:province).uniq

    respond_to do |format|
      format.html
      format.json { render json: @events }
    end
  end

  def show
    @event = Event.find(params[:id])
    @hospitals_nearby = Hospital.where(postal_code: @event.location.postal_code.to_i)
  end

  def category
    @events = Event.where(category: params[:category]).
                order(start_at: :desc).page(params[:page]).this_weeks
    @event_categories = Event.categories.keys - [params[:category]]
    @event_provinces = Location.joins(:events).pluck(:province).uniq
    render :index
  end

  def location
    @events = Event.joins(:location).
                where(locations: { province: params[:location] }).
                order(start_at: :desc).page(params[:page]).this_weeks
    @event_provinces = Location.joins(:events).pluck(:province).uniq
    @event_categories = Event.categories.keys
    render :index
  end
end
