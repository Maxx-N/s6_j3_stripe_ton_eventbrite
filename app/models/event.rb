class Event < ApplicationRecord
  has_many :attendances
  has_many :users, through: :attendances
  belongs_to :organizer, class_name: "User"
  before_destroy :sorry_send

  validates :start_date, presence: { message: "--> L'évènement doit avoir une date et une heure de début" }
  validates :is_future?, presence: { message: "--> L'évènement ne peut commencer que dans le futur" }
  validates :duration, presence: { message: "--> L'évènement doit avoir une durée définie" }
  validates :duration_is_multiple_of_5?, presence: { message: "--> La durée de l'évènement doit être un multiple de 5" }
  validates :title,
    presence: { message: "--> L'évènement doit avoir un titre" },
    length: { minimum: 5, maximum: 140, message: "--> Le titre de l'évènement doit contenir entre 5 et 140 caractères" }
  validates :description,
    presence: { message: "--> L'évènement doit avoir une description" },
    length: { minimum: 20, maximum: 1000, message: "--> La description de l'évènement doit contenir entre 20 et 1000 caractères" }
  validates :price,
    presence: { message: "--> L'évènement doit avoir un prix" },
    numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 1000, message: "--> L'évènement doit coûter entre 1 et 1000 euros" }
  validates :location, presence: { message: "--> L'évènement doit avoir un lieu défini" }

  def is_future?
    self.start_date > DateTime.now
  end

  def duration_is_multiple_of_5?
    self.duration % 5 == 0
  end

  def end_date
    end_date = start_date + (duration * 60) 
  end

  def sorry_send
    UserMailer.cancelled_event_email(self).deliver_now
  end

end
