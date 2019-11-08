class UsersController < ApplicationController
  include UsersHelper
  before_action :authenticate_user!, only: [:show]

  def show
    if is_current_user?(User.find(params[:id]))
      @my_user = User.find(params[:id])
    else
      flash[:not_your_profile] = "Tu ne peux pas accéder aux informations d'un autre utilisateur ... !"
      redirect_to root_path
    end
  end

end
