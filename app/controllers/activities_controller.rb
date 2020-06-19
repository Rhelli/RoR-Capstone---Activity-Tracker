class ActivitiesController < ApplicationController
  def new
    @activity = current_user.activities.build
  end

  def create
    @activity = current_user.activities.build(activity_params)
    if @activity.save
      flash[:notice] = 'Activity Saved.'
    else
      flash[:alert] = 'An error occurred. Please try again.'
    end
    redirect_back(fallback_location: root_path)
  end

  def show
  end

  private

  def activity_params
    params.require(:activity).permit(:name, :amount, :calories, :group_id)
  end
end
