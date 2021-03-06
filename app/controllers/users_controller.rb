class UsersController < ApplicationController
    def index
  	
    end
#New User 
    def new
    if !current_user.nil? && current_user.is_admin 
      @user = User.new
    else
    redirect_to root_url , :notice => "Please login as Admin to access this feature!"
    end
    end
#Create New User
    def create
      @user = User.new(params[:user])
      @user.user_type=params[:role]
      @user.before_add_method(params[:role])
      if params[:role]=="customer"
        @customer=Customer.new(name: @user.full_name,user_id: @user.id,email: @user.email)
      elsif params[:role]=="employee"
        @employee=Employee.new(email: @user.email,first_name: @user.first_name,last_name:@user.last_name,user_id: @user.id)
      end
      if @user.save
        if @user.user_type=="customer"
          @customer.user_id=@user.id
          @customer.save
        elsif @user.user_type=="employee"
           @employee.user_id=@user.id
           @employee.save
        end
  	   cookies[:auth_token] =  @user.auth_token
  	   begin  
        UserMailer.welcome_mail(@user).deliver
	     rescue Exception =>e
	       puts "=================>#{e.message}" 
       end
  	   if @user.user_type=="admin"
          redirect_to admin_manage_user_path , :notice => "Signed up!"
       elsif @user.user_type=="customer"
          redirect_to customers_customer_update_path , :notice => "Signed up!"
       else        
          redirect_to employees_employee_update_path, :notice => "Signed up!"
       end
      else
        render "new"
      end
    end
# Customer  profile page    
    def customer_profile
      @customer=Customer.find(current_user.id)
    end 
end
