class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?


  def after_sign_in_path_for(_resource)
    categories_path
  end

  def after_sign_up_path_for(_resource)
    categories_path
  end

  def admin?
    unless current_user && current_user.role == 1
      redirect_to root_path, notice: 'Only admin'
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:role])
  end
end
