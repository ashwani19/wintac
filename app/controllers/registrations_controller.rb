class RegistrationsController < Devise::RegistrationsController
  def new
    super
  end


    def create
    @user = User.new(user_params)
    @user.user_type=params[:role]

    if @user.save
       @user.before_add_method(params[:role])
       if params[:role]=='employee'
         @employee=Employee.new(first_name:params[:user][:first_name],email:params[:user][:email],user_id:@user.id)
         @employee.save
       elsif params[:role]=='customer'
         @customer=Customer.new(company_name:params[:company_name],email:params[:user][:email],user_id:@user.id)
         @customer.save
       end
      #sign_up(resource_name, @user)
      # warden.authenticate!(:scope =>resource_name, :recall => "#{controller_path}#new")
      # user = Hash.new()
      # user["email"]=  params[:user][:email]
      # user["password"] = params[:user][:password]
      # user["role"]=current_user.roles.first.name
      # user["first_name"]=current_user.first_name
      # render :json=> {:s=> "success"},:status=>201
      render :json=>  {:s=> "failure", :user=> @user},:status=>201
    else
      render :json=>  {:s=> "failure"},:status=>201
    end
  end
 
  def update
    super
  end
  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation,:first_name)
  end
end 