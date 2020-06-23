class GroupsController < ApplicationController
  def new
  end

  def show
    @group = Group.find(params[:id])
  end

  private

  def group_params
    params.require(:group).permit(:name, :description, :creator_id, :icon)
  end
end
