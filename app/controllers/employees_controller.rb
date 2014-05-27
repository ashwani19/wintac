class EmployeesController < ApplicationController
  respond_to :html, :json
  #New Employee 
  def new
  	@employee=Employee.new
  end
  #Update Employee row
  def update_row
      @user=User.find(current_user.id)
      begin
        @employee=@user.employees.first
        @employee.update_attributes(address: params[:address],zip:params[:zip],first_name:params[:first_name],ref_code:params[:ref_code], dob: nil,city: params[:city], last_name:params[:last_name], county:params[:county],mid_name: params[:mid_name], phone_1:params[:phone_1] , phone:params[:phone], ss_no:params[:ss_no], state:params[:state])
         @employee.dob= params[:dob].to_date
         @employee.save
        current_user.first_name=params[:first_name]
        current_user.last_name=params[:last_name]
        current_user.save
        redirect_to employees_employee_home_path ,:notice=>"Update succesfully!"
      rescue Exception => e
        redirect_to employees_employee_update_path ,:notice=>"#{e.message}"
      end
  end
#Employee Home Page
  def employee_home
    @employee=User.find(current_user.id).employees.first
  end
#Employee update page action
  def employee_update
  end
#create new Employee
  def create
      @user = User.new(params[:user])
      @user.user_type=params[:role]
      @user.before_add_method(params[:role])
      @employee=Employee.new(email: @user.email,first_name: @user.first_name,last_name:@user.last_name,user_id: @user.id)
      @employee.transaction do
      if @user.save
        @employee.user_id=@user.id
        @employee.save
  	   cookies[:auth_token] =  @user.auth_token
  	   begin  
        UserMailer.welcome_mail(@user).deliver
	     rescue Exception =>e
	       puts "=================>#{e.message}" 
       end
  	
        redirect_to employees_employee_update_path, :notice => "Signed up!"
      else
        render "new"
      end
    end
    end
    # Method for inline editing
    def update
      @employee=Employee.find(params[:id])
      @employee.update_attributes(params[:employee])
      respond_with @employee
    end
end
