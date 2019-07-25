class VisitDecorator < ApplicationDecorator
  delegate_all

  def start_date
    I18n.l(visit.start_date, format: :datetime) if visit.start_date
  end

  def end_date
    I18n.l(visit.end_date, format: :datetime) if visit.end_date
  end

  def history
    visit.medical_history || {}
  end
end
