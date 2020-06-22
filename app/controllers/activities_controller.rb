class ActivitiesController < ApplicationController
  def new
    @activity = current_user.activities.build
  end

  def create
    @activity = current_user.activities.build(activity_params)
    if @activity.save
      @activity_entry = ActivityEntry.create!(activity_id: @activity.id, group_id: @activity.group_id)
      flash[:notice] = 'Activity Saved.'
    else
      flash[:alert] = 'An error occurred. Please try again.'
    end
    redirect_back(fallback_location: root_path)
  end

  def show
    @activity = Activity.find_by(params[:id])
  end

  private

  def activity_params
    params.require(:activity).permit(:id, :name, :amount, :calories, :group_id)
  end
end
