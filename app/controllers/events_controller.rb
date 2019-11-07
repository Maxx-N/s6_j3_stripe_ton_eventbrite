class EventsController < ApplicationController
  def index
  end

  def show
    @my_event = Event.find(params[:id])
  end

  def new
    unless user_signed_in?
      redirect_to root_path
      flash[:sign_in_to_create] = "Tu dois te connecter (ou t'inscrire) pour créer un évènement !"
    end
  end

  def create
    @e = Event.new
    @e.id = Event.all.length + 1
    @e.organizer = current_user
    @e.title = params[:title]
    @e.start_date = params[:start_date]
    @e.duration = params[:duration]
    @e.description = params[:description]
    @e.price = params[:price]
    @e.location = params[:location]
    if @e.save
      flash[:event_creation_success] = "Félicitations !!! Ton évènement a été créé ! ;)"
      redirect_to root_path
    else
      flash.now[:event_creation_failure] = "Ton évènement n'a pas pu être créé pour les raisons suivantes : "
      render 'new'
    end
  end
end

=begin
  date_string = Date.strptime(params[:time], "%d/%m/%Y").to_s
  time_string = params[:time].to_s
  e.start_date = Time.parse("#{date_string} #{time_string}")
=end