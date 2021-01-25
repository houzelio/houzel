class AppointmentDecorator < ApplicationDecorator
  delegate_all

  def patient_id
    appointment.visit.patient_id
  end

  def examiner_id
    appointment.visit.examiner_id
  end

  def examiner_name
    appointment.visit.examiner.name
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
