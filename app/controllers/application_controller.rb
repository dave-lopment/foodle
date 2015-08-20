class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_order

  before_action :configure_permitted_parameters, if: :devise_controller?

  def current_order
    if(!session[:order_id].nil?)
      Order.find(session[:order_id])
    else
      Order.new
    end
  end

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:name, :email, :postal, :city, :street, :password, :password_confirmation, :remember_me) }
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:name, :email, :postal, :city, :street, :password, :remember_me) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:name, :email, :postal, :city, :street, :password, :password_confirmation, :current_password) }
  end
end
