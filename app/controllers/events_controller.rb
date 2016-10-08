class EventsController < ApplicationController
  def index
    @events = Event.all
    @event_categories = Event.order('category asc').uniq.pluck(:category);
  end

  def category
    @events = Event.where(category: params[:category]).order('start_at desc')
    @category_params = params[:category] ? params[:category] : 'Category'
    @event_categories = Event.where.not(category: params[:category]).uniq.pluck(:category)
    render :index
  end
end
