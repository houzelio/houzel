class VisitController < ApplicationController
  respond_to :json

  def new
    @patients = Patient.select(:id, :name).order(:name)
  end

  def create
    visit = Visit.new
    visit.set_fields(visit_params, visit_fields)

    mcl_history = MedicalHistory.new
    mcl_history.set_fields(mcl_history_params, mcl_history_fields)
    visit.medical_history = mcl_history

    if visit.save()
      respond_with_message(I18n.t(visit.end_date ? 'visit.messages.checked_out' : 'visit.messages.saved'), "success", :ok)
    else
      respond_with visit
    end
  end

  private

  def visit_params
    params.require(:visit).permit(:patient_id, :start_date, :end_date).tap do |p|
      p[:status] = "checked"
      p[:specialist_id] = p[:specialist_id] || current_user.person_id
    end
  end

  def visit_fields
    [:patient_id, :specialist_id, :status, :start_date, :end_date]
  end

  def mcl_history_params
    params.require(:visit).permit(:complaint, :diagnosis, :notes)
  end

  def mcl_history_fields
    [:complaint, :diagnosis, :notes]
  end
end
