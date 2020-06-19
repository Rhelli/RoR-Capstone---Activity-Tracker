class UsersController < ApplicationController
  before_action :authenticate_user!
  def show
    @my_groups = current_user.groups
    @recent_activities_all = User.recent_activities_all(current_user)
    @recent_activities_7 = User.recent_activities_7(current_user)
    @recent_activities_14 = User.recent_activities_14(current_user)
    @recent_activities_21 = User.recent_activities_21(current_user)
    @recent_activities_28 = User.recent_activities_28(current_user)
    @all_activities = current_user.activities.order(created_at: :desc)
  end
end
