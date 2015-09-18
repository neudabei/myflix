module ApplicationHelper

  # def rate_video(selected=nil)
  #   options_for_select([5,4,3,2,1].map {|number| [pluralize(number, "Star")]}, selected)
  # end


  def rate_video(selected=nil)
    options_for_select([5,4,3,2,1].map {|number| [pluralize(number, "Star"), number]}, selected)
  end

  def gravatar_for(person)
    (src="http://www.gravatar.com/avatar/#{Digest::MD5.hexdigest(person)}?s=40")
  end

end
