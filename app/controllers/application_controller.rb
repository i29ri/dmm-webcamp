class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    user_path(resource.id)
  end

  def new
    @book = Book.new
  end


  protected

  def configure_permitted_parameters
   devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:email, :name, :password, :password_confirmation) }
   devise_parameter_sanitizer.permit(:sign_in) { |u| u.permit(:email, :name, :password, :password_confirmation) }

  end

end
