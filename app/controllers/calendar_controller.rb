class CalendarController < ApplicationController
  respond_to :json

  def new
    @patients = patients_select
  end

  private
  
  def patients_select
    Patient.select(:id, :name).order(:name)
  end

end