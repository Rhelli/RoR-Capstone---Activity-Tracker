class GroupsController < ApplicationController
  def new
  end

  def show
    @group = Group.find(params[:id])
    @group_members = Membership.group_memberships(@group)
  end

  private

  def group_params
    params.require(:group).permit(:name, :description, :creator_id, :icon)
  end
end
