class AppointmentController < ApplicationController
  respond_to :json

  def index
    page = (params[:page] || 1).to_i
    per_page = (params[:per_page] || 10).to_i

    appointments = Appointment.select_all(:appointment).select_append(:name).association_join(visit: :patient)
    appointments = appointments.where(status: 'scheduled')
    if params_filter(:name)
      appointments = appointments.where(Sequel.ilike(:name, "%#{params_filter(:name)}%"))
    end

    if params_filter(:start_date)
      appointments = appointments.where(Sequel.lit("appointment.start_date >= ?", params_filter(:start_date)))
    end

    if params_filter(:end_date)
      appointments = appointments.where(Sequel.lit("appointment.end_date <= ?", params_filter(:end_date)))
    end

    appointments = appointments.order(Sequel.desc(Sequel[:appointment][:start_date])).paginate(page, per_page)
    @appointments = AppointmentDecorator.decorate_collection(appointments)
  end

  def new
    @patients = patients_select
    @examiners = SafeQuery::MedProfessionals.new.examiners
  end

  def create
    appointment = Appointment.new
    appointment.set_fields(appointment_params, appointment_fields)

    visit = Visit.new(status: "scheduled")
    visit.set_fields(visit_params, visit_fields)

    visit.appointment = appointment

    if visit.save()
      respond_with_message(I18n.t('appointment.messages.scheduled', name: visit.patient.name), "success", :ok)
    else
      respond_with visit
    end
  end

  def show
    appointment = Appointment[params[:id]]
    raise Sequel::NoExistingObject unless appointment.present? && appointment.scheduled?

    @appointment =  AppointmentDecorator.new(appointment)

    @patients = patients_select
    @examiners = SafeQuery::MedProfessionals.new.examiners
  end

  def update
    appointment = Appointment[params[:id]]
    raise Sequel::NoExistingObject unless appointment.present?

    visit = appointment.visit
    visit.set_appointment_fields(appointment_params, appointment_fields)

    if visit.update_fields(visit_params, visit_fields)
      respond_with_message(I18n.t('appointment.messages.scheduled', name: visit.patient.name), "success", :ok)
    else
      respond_with visit
    end
  end

  def destroy
    appointment = Appointment[params[:id]]
    raise Sequel::NoExistingObject unless appointment.present? && appointment.scheduled?

    visit = appointment.visit

    if visit.destroy()
      respond_with_message(I18n.t('appointment.messages.deleted'), "success", :ok)
    end
  end

  private

  def patients_select
    Patient.select(:id, :name).where(deleted_at: nil).order(:name)
  end

  def appointment_params
    params.require(:appointment).permit(:description).tap do |p|
      p[:start_date] = merge_into_datetime(params[:date], params[:start_time])
      p[:end_date] = merge_into_datetime(params[:date], params[:end_time])
    end
  end

  def appointment_fields
    [:description, :start_date, :end_date]
  end

  def visit_params
    params.require(:appointment).permit(:patient_id, :examiner_id)
  end

  def visit_fields
    [:patient_id, :examiner_id]
  end

  def merge_into_datetime(date, time)
    if date.present? && time.present?
      DateTime.parse([date, time].join(' '))
    end
  end
end
