class Api::V1::EventsController < ApplicationController
  before_action :set_headers

  def index
    @events = Event.order(start_at: :desc).
                this_weeks.
                page(params[:page])
    render :index, status: :ok
  end

  def show
    @event = Event.find(params[:id])
    render :show, status: :ok
  end

  def category
    category =
      case params[:category]
      when 'แผ่นดินไหว' then 'earthquake'
      when 'น้ำท่วม'    then 'flood'
      when 'ฝนตกหนัก'  then 'rainfall'
      when 'ฝนตก'     then 'rainfall'
      else params[:category]
      end

    @events = Event.where(category: category).
                order(start_at: :desc).
                this_weeks.
                page(params[:page])
    render :index, status: :ok
  end

  def location
    @events = Event.joins(:location).
                where(locations: { province: params[:location] }).
                order(start_at: :desc).
                this_weeks.
                page(params[:page])
    render :index, status: :ok
  end

  def postalcode
    @events = Event.joins(:location).
                where(locations: { postal_code: params[:postalcode] }).
                order(start_at: :desc).
                this_weeks.
                page(params[:page])
    render :index, status: :ok
  end

  private
  
  def set_headers
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'GET'
    headers['Access-Control-Request-Method'] = '*'
    headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept, Authorization'
  end
end
