class GroupsController < ApplicationController
  def new
    @group = current_user.groups.build
  end

  def create
    @group = current_user.groups.build(group_params)
    if @group.save
      Membership.create!(user_id: current_user.id, group_id: @group.id)
      flash[:notice] = "You created #{@group.name}. Now to get some team members!"
      redirect_to group_path(@group)
    else
      flash[:alert] = 'An Error Ocurred! Please Try Again.'
      redirect_back(fallback_location: root_path)
    end
  end

  def show
    @group = Group.find(params[:id])
    @group_members = Membership.group_memberships(@group).includes([:user])
    @group_activities = Group.recent_activities(@group).includes([:author]).order(created_at: :desc)
    @my_groups = Membership.my_memberships(current_user)
  end

  def destroy
    @group = Group.find(params[:id])
    if @group.destroy
      flash[:notice] = "The group #{@group.name} has been deleted."
      redirect_to user_path(current_user)
    else
      flash[:alert] = 'An error occurred. Please try again.'
      redirect_back(fallback_location: root_path)
    end
  end

  private

  def group_params
    params.require(:group).permit(:name, :description, :icon)
  end
end
