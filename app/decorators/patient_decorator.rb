class PatientDecorator < ApplicationDecorator
  delegate_all

  def appointments
    if context[:relation].eql? "appointment"
      patient.appointment || {}
    end
  end
end
