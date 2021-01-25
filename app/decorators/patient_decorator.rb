class PatientDecorator < ApplicationDecorator
  delegate_all

  def birthday
    I18n.l(patient.birthday) if patient.birthday
  end

  def scheduled_appointments
    AppointmentDecorator.decorate_collection(patient.scheduled_appointments) if context[:scope].eql? "extended"
  end
end
