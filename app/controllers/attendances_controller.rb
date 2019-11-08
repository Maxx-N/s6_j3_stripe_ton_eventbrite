class AttendancesController < ApplicationController
  def create
    a = Attendance.new
    a.user = current_user
    a.event_id = params[:my_event_id]
    unless a.event.users.include?(a.user)
      a.save
      redirect_to event_path(params[:my_event_id])
      flash[:you_attend] = "Bienvenu(e) #{current_user.first_name} ! Tu viens de t'inscrire à #{a.event.title} ! :D"
    else
      redirect_to events_path
      flash[:already_attending] = "Tu participes déjà à cet évènement ;)"
    end
  end
end
