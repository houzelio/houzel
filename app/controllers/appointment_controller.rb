class AppointmentController < ApplicationController
  respond_to :json

  def new
    @patients = patients_select
    @examiners = SafeQuery::MedProfessionals.new.examiners
  end

  private

  def patients_select
    Patient.select(:id, :name).order(:name)
  end

  def appointment_params
    params.require(:appointment).permit(:description).tap do |p|
      p[:start_date] = DateTime.parse([params[:date], params[:start_time]].join(' '))
      p[:end_date] = DateTime.parse([params[:date], params[:end_time]].join(' '))
    end
  end

  def appointment_fields
    [:description, :start_date, :end_date]
  end

  def visit_params
    params.require(:appointment).permit(:patient_id, :specialist_id)
  end

  def visit_fields
    [:patient_id, :specialist_id]
  end
end
