class Admin::BaseController < ApplicationController
  before_action :authenticate_user!
  before_action :check_admin!

  protected

  def check_admin!
    unless current_user.admin?
      flash[:alert] = "You don't have sufficient rights!"
      redirect_to root_path
    end
  end
end
