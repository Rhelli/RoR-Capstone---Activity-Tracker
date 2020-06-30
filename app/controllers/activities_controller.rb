class ActivitiesController < ApplicationController
  def new
    @activity = current_user.activities.build
  end

  def create
    @activity = current_user.activities.build(activity_params)
    if @activity.save
      @activity_entry = ActivityEntry.create!(activity_id: @activity.id, group_id: @activity.group_id)
      flash[:notice] = 'Activity Saved.'
      redirect_to activity_path(@activity)
    else
      flash[:alert] = 'An error occurred. Please try again.'
      redirect_back(fallback_location: root_path)
    end
  end

  def show
    @activity = Activity.find(params[:id])
    @my_groups = Membership.my_memberships(current_user)
  end

  def destroy
    @activity = Activity.find(params[:id])
    @activity.destroy
    flash[:notice] = 'Activity Deleted.'
    redirect_to user_path(current_user)
  end

  private

  def activity_params
    params.require(:activity).permit(:id, :name, :amount, :calories, :group_id)
  end
end
