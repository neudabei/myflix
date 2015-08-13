module ApplicationHelper

  def rate_video(selected=nil)
    options_for_select([5,4,3,2,1].map {|number| [pluralize(number, "Star")]}, selected)
  end
  
end
