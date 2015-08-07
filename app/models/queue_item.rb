class QueueItem < ActiveRecord::Base
  belongs_to :user
  belongs_to :video

  delegate :category, to: :video # Rails helper to replace category method
  delegate :title, to: :video, prefix: :video

  # def video_title
  #   video.title
  # end
  # -> replaced by delegate :title...

  def rating
    review = Review.where(user_id: user.id, video_id: video.id).first
    review.rating if review
  end

  def category_name
    category.name
    # video.category.name
    # -> video. was replaced by delegate helper
  end

  # def category
  #   video.category
  # end
  # -> replaced by delegate helper
end