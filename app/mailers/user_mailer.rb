class UserMailer < ApplicationMailer
  default from: 'no-reply@montpel-events.com'
 
  def welcome_email(user)
    #on récupère l'instance user pour ensuite pouvoir la passer à la view en @user
    @user = user 

    #on définit une variable @url qu'on utilisera dans la view d’e-mail
    @url  = 'http://montpel-events.herokuapp.com/login' 

    # c'est cet appel à mail() qui permet d'envoyer l’e-mail en définissant destinataire et sujet.
    mail(to: @user.email, subject: 'Bienvenue chez MontpelEvents ! ;)') 
  end

  def new_attendance_email(attendance)
    @attendance = attendance
    mail(to: @attendance.event.organizer.email, subject: "Nouveau participant à votre évènement!!!")
  end

  def cancelled_event_email(event)
    @event = event
    @url  = 'http://montpel-events.herokuapp.com/login'
    @event.users.each do |user|
      @user = user
      mail(to: user.email, subject: "Annulation de l'évènement #{@event.title} :(")
    end
  end

end
