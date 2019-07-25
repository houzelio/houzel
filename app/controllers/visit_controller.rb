class VisitController < ApplicationController
  respond_to :json

  def new
    @patients = Patient.select(:id, :name).order(:name)
  end
end
