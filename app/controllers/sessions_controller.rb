#Class use for create the session and destroy the session
class SessionsController < ApplicationController
  def new
  end
# Create the user session
# def create
#   if cookies[:auth_token].nil?
#   user_type=params[:user_type]
#   user = User.find_by_email_and_is_active(params[:email],true)
#   if user and user_type=='admin' and user.is_admin
#     if params[:remember_me]
#       cookies.permanent[:auth_token] = user.auth_token
#     else
#       cookies[:auth_token] = user.auth_token
#     end
    
#        redirect_to admin_admin_home_path , :notice => "Logged in!"
#   elsif user && user_type=='normal' and !user.is_admin
#     if params[:remember_me]
#       cookies.permanent[:auth_token] = user.auth_token
#     else
#       cookies[:auth_token] = user.auth_token
#     end
#     if user.is_customer 
#        redirect_to customers_customer_home_path, :notice => "Logged in!"  
#     elsif user.is_employee 
#        redirect_to employees_employee_home_path, :notice => "Logged in!"
#     end
#   else
#     flash.now.alert = "Invalid email or password"
#     render "new"
#   end
# else
#   flash.now.alert = "You already Logged in"
#   render "new"
# end
# end
# #Destroy the user session
# def destroy
#   cookies.delete(:auth_token)
#   redirect_to root_url, :notice => "Logged out!"
# end
def create
  unless (params[:email] && params[:password])
      #render :json=> {:errors=>'Invalid Login'} , :status=>401
      return missing_params
  end
  @user = User.authenticate(params[:email], params[:password])
  if @user
    if params[:remember]
      cookies.permanent[:auth_token] = @user.auth_token
    else
      cookies[:auth_token] = @user.auth_token
    end

    

    data = {
        user_id: @user.id,
        auth_token: @user.auth_token
    }


    render json: data, status: 201
  else
     render :json=> {:errors=>'Invalid Login'} , :status=>401
  end
end

def destroy
  return missing_params unless cookies[:auth_token]
  @user = User.find_by auth_token:cookies[:auth_token]
  cookies.delete(:auth_token)
  render json: { user_id: @user.id }, status: 200
end





def missing_params
   render json: {:errors=>'Email or Password field should not blank'}, status: 400
end

def invalid_credentials
  render json: {:errors=>'Invalid Login'}, status: 401
end

end
