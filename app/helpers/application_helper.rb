module ApplicationHelper
  def time_converter(mins, stacked=nil)
    hours = mins / 60
    remainder = mins % 60
    if hours < 1
      "#{remainder} mins"
    else
      "#{hours}h:#{remainder}m"
    end
  end
end
