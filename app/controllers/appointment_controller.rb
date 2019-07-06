class AppointmentController < ApplicationController
  respond_to :json

  def new
    @patients = patients_select
    @examiners = SafeQuery::MedProfessionals.new.examiners
  end

  def create
    visit = Visit.new(status: "scheduled")
    visit.set_fields(visit_params, visit_fields)

    appointment = Appointment.new
    appointment.set_fields(appointment_params, appointment_fields)
    visit.appointment = appointment

    if visit.save()
      respond_with_message(I18n.t('appointment.messages.scheduled', name: visit.patient.name), "success", :ok)
    else
      respond_with visit
    end
  end

  def show
    appointment = Appointment.first(id: params[:id])
    raise Sequel::NoExistingObject unless appointment.present?

    @appointment =  AppointmentDecorator.new(appointment)

    @patients = patients_select
    @examiners = SafeQuery::MedProfessionals.new.examiners
  end

  def update
    appointment = Appointment.first(id: params[:id])
    raise Sequel::NoExistingObject unless appointment.present?

    visit = appointment.visit
    visit.set_appointment_fields(appointment_params, appointment_fields)

    if visit.update_fields(visit_params, visit_fields)
      respond_with_message(I18n.t('appointment.messages.scheduled', name: visit.patient.name), "success", :ok)
    else
      respond_with visit
    end
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
