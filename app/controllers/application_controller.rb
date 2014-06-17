class ApplicationController < ActionController::Base
  #protect_from_forgery with: :null_session, if: Proc.new { |c| c.request.format == 'application/json' }
  helper_method :current_user,:logged_in?, :admin_logged_in?,:customer_required?,:employee_required?,:admin_required?
  
  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = "Access denied!"
    redirect_to root_url
  end

private

def current_user
  #@current_user ||= User.find(session[:user_id]) if session[:user_id]
  @current_user ||= User.find_by_auth_token!(cookies[:auth_token]) if cookies[:auth_token]
end
#user is logged in
def require_user
    unless current_user
      store_location
      flash[:error] = "please loging"
      redirect_to log_in_path
      return false
    end
  end
 #session is not nill
   def logged_in?
    !current_user.nil?
  end
  #admin is logged in
  def admin_logged_in?
    logged_in? && current_user.is_admin
  end

  def store_location
    session[:return_to] = request.fullpath
  end
#admin is not nill
  def admin_required?
    if !current_user.nil? && current_user.is_admin
      return true
      else
      flash[:error] = "Please login as admin to acces this feature"
      redirect_to root_url and return false
    end
  end
#customer is not nil
  def customer_required?
    if !current_user.nil? && current_user.is_customer
    return true
    else
      flash[:error] = "Please login as Customer to acces this feature"
      redirect_to(root_url) and return false
    end
  end
#employee is not nill
  def employee_required?
    if !current_user.nil? && current_user.is_employee
      return true
      else
      flash[:error] = "Please login as Employee to acces this feature"
      redirect_to root_url and return false
    end
  end
end
