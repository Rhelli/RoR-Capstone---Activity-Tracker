class ActivityEntriesController < ApplicationController
  def show
    @my_activities = ActivityEntry.my_activities(current_user)
  end
end
