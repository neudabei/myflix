class RatingDecorator
  attr_reader :video

  def initialize(video)
    @video = video
  end

  def rating
    review_sum = 0
    @video.reviews.each do |review|
      review_sum += review.rating
    end
    @video.reviews.present? ? "#{review_sum/@video.reviews.count}/5.0" : "N/A"
  end
end