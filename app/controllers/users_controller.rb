class UsersController < ApplicationController
  before_action :authenticate_user!
  def show
    @my_groups = current_user.groups
  end
end
