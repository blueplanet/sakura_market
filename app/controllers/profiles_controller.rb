class ProfilesController < ApplicationController
  before_action :set_profile, only: [:edit, :update]

  def show
    @profile = Profile.find params[:id]
  end

  def update
    if @profile.update profile_params
      redirect_to :root, notice: t('.success')
    else
      flash.now[:alert] = t('.failed')
      render :edit
    end
  end

  private

  def set_profile
    @profile = current_user.profile
  end

  def profile_params
    params.require(:profile).permit(:nick_name, :avatar, :avatar_cache)
  end
end
