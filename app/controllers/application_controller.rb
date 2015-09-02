class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_order, :allow_only_admin, :allow_only_normal_user

  before_action :configure_permitted_parameters, if: :devise_controller?

  def current_order

    if(!session[:order_id].nil?)
      if Order.find(session[:order_id]).Erstellung?
        Order.find(session[:order_id])
      else
        session[:order_id] = nil
        Order.new
      end
    else
      Order.new
    end
  end

  def allow_only_admin(redirectToPath)
    if !current_user.try(:admin?)
      redirect_to redirectToPath
    end
  end

  def allow_only_normal_user(redirectToPath)
    if current_user.try(:admin?)
      redirect_to redirectToPath
    end
  end

  def after_sign_in_path_for(resource)
      if(current_user.try(:admin?))
          orders_path
      else
          root_path
      end
  end

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:name, :email, :postal, :city, :street, :password, :password_confirmation, :remember_me) }
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:name, :email, :postal, :city, :street, :password, :remember_me) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:name, :email, :postal, :city, :street, :password, :password_confirmation, :current_password) }
  end
end
