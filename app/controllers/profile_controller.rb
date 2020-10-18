class ProfileController < ApplicationController
  before_action :authenticate_user!

  def edit
    @user = current_user
  end

  def update
    current_user.update_attribute(:name, params.require(:user)[:name])
    redirect_to root_path
  end
end
