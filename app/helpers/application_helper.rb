module ApplicationHelper

  def rate_video
    options_for_select([5,4,3,2,1].map {|number| [pluralize(number, "Star")]})
  end
  
end
