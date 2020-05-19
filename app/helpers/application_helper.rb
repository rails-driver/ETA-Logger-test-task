module ApplicationHelper
  def format_date(date)
    date.to_formatted_s(:short)
  end
end
