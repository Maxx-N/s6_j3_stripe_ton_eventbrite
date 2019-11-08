class AttendancesController < ApplicationController
  def create
    a = Attendance.new
    a.user = current_user
    a.event_id = params[:my_event_id]
    unless a.event.users.include?(a.user)
      a.save
      redirect_to event_path(params[:my_event_id])
      if current_user.first_name
        flash[:you_attend] = "Bienvenu(e) #{current_user.first_name} ! Tu viens de t'inscrire à #{a.event.title} ! :D"
      else
        flash[:you_attend] = "Bienvenu(e) #{current_user.email} ! Tu viens de t'inscrire à #{a.event.title} ! :D"
      end
    else
      redirect_to events_path
      flash[:already_attending] = "Tu participes déjà à cet évènement ;)"
    end
  end

  def destroy
    a = Attendance.find(params[:id])
    a.destroy
    redirect_to events_path
    flash[:unattending] = "Tu t'es bien désinscrit(e) de l'évènement #{a.event.title}"
  end
end
