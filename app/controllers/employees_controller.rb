#Class use for controlle and manage the employee
class EmployeesController < ApplicationController
  #skip_before_filter  :verify_authenticity_token
  skip_before_filter :verify_authenticity_token, :if => Proc.new { |c| c.request.format == 'application/json' }
  #New Employee 
  def new
  	@employee=Employee.new
  end
  #Update Employee row
  def update_row
      @user=User.find(current_user.id)
      begin
        @employee=@user.employees.first
       # @employee.update_attributes(address: params[:address],emp_type:params[:emp_type],zip:params[:zip],first_name:params[:first_name],ref_code:params[:ref_code], dob: nil,city: params[:city], last_name:params[:last_name], county:params[:county],mid_name: params[:mid_name], phone_1:params[:phone_1] , phone:params[:phone], ss_no:params[:ss_no], state:params[:state])
         @employee.update_attributes(employee_params)
         @user.address=params[:employee][:address].strip if !params[:employee][:address].blank?
         @user.save
         if !params[:employee][:doc_or_image].blank?
          uploaded_file = params[:employee][:doc_or_image]
          @employee.doc_or_image=uploaded_file.read
          @employee.filename=params[:employee][:doc_or_image].original_filename
          @employee.mime_type=params[:employee][:doc_or_image].content_type
         end
         
         @employee.save
        @user.first_name=params[:employee][:first_name]
        @user.last_name=params[:employee][:last_name]
        @user.save
        redirect_to employees_employee_home_path ,:notice=>"Update succesfully!"
      rescue Exception => e
        redirect_to employees_employee_update_path ,:notice=>"#{e.message}"
      end
  end
#Employee Home Page
  def employee_home
    if employee_required?
    @employee=User.find(current_user.id).employees.first
  end
  end
#Employee update page action
  def employee_update

    if employee_required?
      @employee=Employee.find(current_user.employees.first.id)
    end
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
    def serve
    @employee=Employee.find(params[:id])
    send_data(@employee.doc_or_image, :type => @employee.mime_type, :filename => "#{@employee.filename}", :disposition => "download")
  end

  private
    

    # Never trust parameters from the scary internet, only allow the white list through.
    def employee_params
      params.require(:employee).permit(:address,:emp_id,:emp_type,:ref_code,:zip,:user_id,:city, :county, :dob, :email, :first_name, :last_name, :mid_name, :phone, :phone_1, :ss_no, :state,:notes,:devision,:hire_date,:termination_date,:raise_date,:raise_amount)
    end
end
