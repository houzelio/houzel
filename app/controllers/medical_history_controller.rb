class MedicalHistoryController < ApplicationController
  before_action :authenticate_user!

  respond_to :json

  def index
    page = pagination_value_for(:page)
    per_page = pagination_value_for(:per_page)

    mcl_histories = MedicalHistory.association_join(:visit)
    if params[:visit_id]
      patient_id = Visit[params[:visit_id]][:patient_id]
    else
      patient_id = params[:patient_id]
    end

    mcl_histories = mcl_histories.where(patient_id: patient_id).paginate(page, per_page)
    @mcl_histories = mcl_histories
  end
end
