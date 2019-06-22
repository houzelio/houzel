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
end
