class SessionsController < ApplicationController
  def new
  end

def create
  user = User.find_by_email_and_is_active(params[:email],true)
  if user
    if params[:remember_me]
      cookies.permanent[:auth_token] = user.auth_token
    else
      cookies[:auth_token] = user.auth_token
    end
    if user.user_type=='admin'
       redirect_to admin_admin_home_path , :notice => "Logged in!"
    elsif user.user_type=='customer'
       redirect_to customers_customer_home_path, :notice => "Logged in!"  
    else
      redirect_to employees_employee_home_path, :notice => "Logged in!"
    end
  else
    flash.now.alert = "Invalid email or password"
    render "new"
  end
end

def destroy
  cookies.delete(:auth_token)
  redirect_to root_url, :notice => "Logged out!"
end
end
