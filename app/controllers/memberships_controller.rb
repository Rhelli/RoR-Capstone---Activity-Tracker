class MembershipsController < ApplicationController
  def new
    @membership = current_user.memberships.build
  end

  def create
    @membership = current_user.memberships.build(membership_params)
    if @membership.save
      flash[:notice] = 'Welcome to the club!'
    else
      flash[:alert] = 'An Error Occurred! Please Try Again.'
    end
    redirect_back(fallback_location: root_path)
  end

  def show
    @my_memberships = Membership.my_memberships(current_user)
    @non_memberships = User.undiscovered_groups(current_user)
  end

  def destroy
    @membership = Membership.find_by(membership_params)
    @membership.destroy
    flash[:notice] = 'Membership terminated. You can join again at any time!'
    redirect_back(fallback_location: root_path)
  end

  private

  def membership_params
    params.permit(:user_id, :group_id)
  end
end
