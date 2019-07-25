class VisitController < ApplicationController
  respond_to :json

  def new
    @patients = Patient.select(:id, :name).order(:name)
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
