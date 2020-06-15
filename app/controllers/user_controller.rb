class UserController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def new
  end

  def create
  end

  def update
  end

  def destroy
  end
end
