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
      render :json=> {:s=> "Congratulations! Acccount is created", :user=> @user},:status=>201
    else
      render :json=>  {:s=> "Sorry! Try later"},:status=>400
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