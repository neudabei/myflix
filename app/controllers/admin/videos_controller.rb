class Admin::VideosController < AdminsController
  def new
    @video = Video.new
  end

  def create
    @video = Video.new(video_params)
    if @video.save
      flash[:success] = "You have successfully added the video #{@video.title}"
      redirect_to new_admin_video_path
    else 
      flash.now[:error] = "The video could not be added. Please check the errors below."
      render :new
    end
  end

  private

  def video_params
    params.require(:video).permit(:title, :description, :small_cover, :large_cover, :video_url, :category_id)
  end
end