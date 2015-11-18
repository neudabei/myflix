module ApplicationHelper
 def video_rating_options(selected=nil)
    options_for_select([5,4,3,2,1].map {|number| [pluralize(number, "Star"), number]}, selected)
  end

  def gravatar_for(person)
    (src="http://www.gravatar.com/avatar/#{Digest::MD5.hexdigest(person)}?s=40")
  end

  def rating_selection_options
    (10..50).map {|num| num / 10.0}
  end
end
