class PatientController < ApplicationController
  before_action :authenticate_user!

  respond_to :json

  def index
    page = pagination_value_for(:page)
    per_page = pagination_value_for(:per_page)

    patients = Patient.where(deleted_at: nil)
    if params_filter(:name)
      patients = patients.where(Sequel.ilike(:name, "%#{params_filter(:name)}%"))
    end

    patients = patients.order(:name).paginate(page, per_page)
    @patients = patients
  end

  def create
    patient = Patient.new
    patient.set_fields(patient_params, patient_fields)

    if patient.save()
      respond_with_message(I18n.t('patient.messages.saved', name: patient.name), "success", :ok)
    else
      respond_with patient
    end
  end

  def show
    patient = Patient[params[:id]]
    raise Sequel::NoExistingObject unless patient.present?

    @patient = PatientDecorator.new(patient, context: {scope: params[:scope]})
  end

  def update
    patient = Patient[params[:id]]
    raise Sequel::NoExistingObject unless patient.present?

    if patient.update_fields(patient_params, patient_fields)
      respond_with_message(I18n.t('patient.messages.updated', name: patient.name), "success", :ok)
    else
      respond_with patient
    end
  end

  def destroy
    patient = Patient[params[:id]]
    raise Sequel::NoExistingObject unless patient.present?

    if patient.soft_destroy()
      respond_with_message(I18n.t('patient.messages.deleted'), "success", :ok)
    end
  end

  private

  def patient_params
    params.require(:patient).permit(
      :id, :name, :birthday, :sex, :blood_type, :phone, :email,
      :site, :zip_code, :address, :profession, :parent_name, :observation
    )
  end

  def patient_fields
    [:name, :birthday, :sex, :blood_type, :phone, :email,
      :site, :zip_code, :address, :profession, :parent_name, :observation]
  end

end
