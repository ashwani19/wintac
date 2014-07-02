class EmployeesController < ApplicationController
  load_and_authorize_resource
	def update_row
   @user=User.find(params[:user_id])


   begin
    @employee=@user.employee
    a=@employee.update_attributes(employee_params)

    @user.address=params[:employee][:address].strip if !params[:employee][:address].blank?
    @user.save
    if !params[:employee][:doc_or_image].blank?

      uploaded_file = params[:employee][:doc_or_image]
      @employee.doc_or_image=uploaded_file.read
      @employee.filename=params[:employee][:doc_or_image].original_filename
      @employee.mime_type=params[:employee][:doc_or_image].content_type
    end

    b= @employee.save
    @user.first_name=params[:employee][:first_name]
    @user.last_name=params[:employee][:last_name]
    @user.save

    render :json=>@user
  rescue Exception => e
    puts "===============#{e.message}"
   render :json=>@user,:status=>401
 end
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
