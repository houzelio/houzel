class MedicalHistoryController < ApplicationController
  respond_to :json

  def index
    page = pagination_value_for(:page)
    per_page = pagination_value_for(:per_page)

    mcl_histories = MedicalHistory.association_join(:visit).paginate(page, per_page)
    if params[:visit_id]
      patient_id = Visit.first(id: params[:visit_id])[:patient_id]
    else
      patient_id = params[:patient_id]
    end
    
    mcl_histories = mcl_histories.where(patient_id: patient_id)

    @mcl_histories = mcl_histories
  end
end