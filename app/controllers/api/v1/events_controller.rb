class Api::V1::EventsController < ApplicationController
  def index
    @events = Event.order(start_at: :desc).this_weeks.limit(20)
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
                order(start_at: :desc).page(params[:page]).this_weeks
    render :index, status: :ok
  end

  def location
    @events = Event.joins(:location).
                where(locations: { province: params[:location] }).
                order(start_at: :desc).page(params[:page]).this_weeks
    render :index, status: :ok
  end
end
