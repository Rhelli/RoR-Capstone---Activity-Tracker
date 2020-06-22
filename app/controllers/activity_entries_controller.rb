class ActivityEntriesController < ApplicationController
  def show
    @my_activities = current_user.activities.all
  end

  def new
    @activity_entry = ActivityEntry.new
  end

  def create
    @activity_entry = ActivityEntry.new(activity_entry_params)
  end

  private

  def activity_entry_params
    permit(:activity_entry).permit(:activity_id, :group_id)
  end
end
