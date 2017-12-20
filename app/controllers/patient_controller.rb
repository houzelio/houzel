class PatientController < ApplicationController
  respond_to :json

  def index
    page = (params[:page] || 1).to_i
    per_page = (params[:per_page] || 10).to_i
    p = Patient.dataset.order(:name).paginate(page, per_page)

    @patients = p
  end

  private

  def patient_params
    params.require(:patient).permit(
      :id, :name, :birthday, :sex, :blood_type, :phone,:email, 
      :location, :zip_code, :address, :profession, :parent, :observation
    )
  end

end
