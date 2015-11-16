class RelationshipsController < AuthenticatedController
  def index
    @relationships = current_user.following_relationships
  end

  def destroy
    relationship = Relationship.find(params[:id])
    relationship.destroy if relationship.follower == current_user
    redirect_to people_path
  end

  def create
    leader = User.find(params[:leader_id])
    Relationship.create(leader: leader, follower: current_user) if current_user.can_follow?(leader)
    #AppMailer.notify_on_someone_following_you(current_user).deliver
    redirect_to people_path
  end
end