class PatientDecorator < ApplicationDecorator
  delegate_all

  def birthday
    I18n.l(patient.birthday) if patient.birthday
  end

  def appointments
    if context[:relation].eql? "appointment"
      patient.appointment || {}
    end
  end
end
