class PatientController < ApplicationController
  respond_to :json

  def index
    page = pagination_value_for(:page)
    per_page = pagination_value_for(:per_page)

    patients = Patient.order(:name).paginate(page, per_page).where(removed_at: nil)
    if params_filter(:name)
      patients = patients.where(Sequel.ilike(:name, "%#{params_filter(:name)}%"))
    end

    @patients = patients
  end
  end

  private

  def patient_params
    params.require(:patient).permit(
      :id, :name, :birthday, :sex, :blood_type, :phone,:email, 
      :location, :zip_code, :address, :profession, :parent, :observation
    )
  end

end
