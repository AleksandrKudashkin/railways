class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def after_sign_in_path_for(_resource)
    flash[:notice] = "Hello, #{current_user.first_name}!"
    current_user.admin? ? admin_root_path : root_path
  end
end
