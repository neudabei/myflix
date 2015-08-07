class QueueItemsController < ApplicationController
  before_filter :require_user

  def index
    @queue_items = current_user.queue_items
  end

  def create
    video = Video.find(queue_items_params)
    redirect_to my_queue_path
  end

  def queue_items_params
    params.require(:queue_item).permit!
  end
end