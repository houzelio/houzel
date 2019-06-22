class AppointmentDecorator < ApplicationDecorator
  delegate_all

  def patient_id
    appointment.visit.patient_id
  end

  def specialist_id
    appointment.visit.specialist_id
  end

  def date
    I18n.l(appointment.start_date, format: :date)
  end

  def start_time
    appointment.start_date.strftime("%H:%M")
  end

  def end_time
    appointment.end_date.strftime("%H:%M")
  end
end
