class EventsController < ApplicationController
  def index
  end

  def show
    @my_event = Event.find(params[:id])
  end

  def new
  end

  def create
    e = Event.new
    e.id = Event.all.length + 1
    e.organizer = current_user
    e.title = params[:title]
    e.start_date = params[:start_date]
    e.duration = params[:duration]
    e.description = params[:description]
    e.price = params[:price]
    e.location = params[:location]
    tp e
    if e.save
      redirect_to '/'
    else
      render 'new'
    end
  end
end

=begin
  date_string = Date.strptime(params[:time], "%d/%m/%Y").to_s
  time_string = params[:time].to_s
  e.start_date = Time.parse("#{date_string} #{time_string}")
=end