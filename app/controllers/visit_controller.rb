class VisitController < ApplicationController
  respond_to :json

  def index
    page = (params[:page] || 1).to_i
    per_page = (params[:per_page] || 10).to_i

    visits = Visit.select_all(:visit).select_append(:name, :sex).association_join(:patient)
    visits = visits.where(status: 'checked')
    if params_filter(:name)
      visits = visits.where(Sequel.ilike(:name, "%#{params_filter(:name)}%"))
    end

    visits = visits.order(Sequel.desc(:start_date)).paginate(page, per_page)
    @visits = VisitDecorator.decorate_collection(visits)
  end

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

  def show
    visit = Visit[params[:id]]
    raise Sequel::NoExistingObject unless visit.present?

    @visit =  VisitDecorator.new(visit)
  end

  def update
    visit = Visit[params[:id]]
    raise Sequel::NoExistingObject unless visit.present?

    visit.set_medical_history_fields(mcl_history_params, mcl_history_fields)
    checked_out = visit_params[:end_date].present? && !visit.end_date

    if visit.update_fields(visit_params, visit_fields.without(:patient_id))
      respond_with_message(I18n.t(checked_out ? 'visit.messages.checked_out' : 'visit.messages.updated'), "success", :ok)
    else
      respond_with visit
    end
  end

  def destroy
    visit = Visit[params[:id]]
    raise Sequel::NoExistingObject unless visit.present?

    if visit.destroy()
      respond_with_message(I18n.t('visit.messages.deleted'), "success", :ok)
    end
  end

  private

  def visit_params
    params.require(:visit).permit(:patient_id, :examiner_id, :start_date, :end_date).tap do |p|
      p[:status] = "checked"
      p[:examiner_id] = p[:examiner_id] || current_user.person_id
    end
  end

  def visit_fields
    [:patient_id, :examiner_id, :status, :start_date, :end_date]
  end

  def mcl_history_params
    params.require(:visit).permit(:complaint, :diagnosis, :notes)
  end

  def mcl_history_fields
    [:complaint, :diagnosis, :notes]
  end
end
