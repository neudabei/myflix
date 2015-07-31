class Category < ActiveRecord::Base
  has_many :videos, -> {order("Created_at DESC")}

  def recent_videos
    videos.first(6)
  end

end