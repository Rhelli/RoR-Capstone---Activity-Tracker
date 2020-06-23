class MembershipsController < ApplicationController
  def show
    @my_memberships = Membership.my_memberships(current_user)
    @non_memberships = User.undiscovered_groups(current_user)
  end
end
