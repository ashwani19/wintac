require 'will_paginate/array'
# Class use for Admin panal
class AdminController < ApplicationController
  skip_before_filter :verify_authenticity_token, :if => Proc.new { |c| c.request.format == 'application/json' } # To verify authenticity toke on submit the form
    
  #Method used for admin login action Page   
  def new
  
  end
  # Admin Home page
  def admin_home
    if admin_required? # Condition for checking admin log in
    end
  end

  #Manage user ui page action
  def manage_user
    if admin_required?
      @user=User.paginate(:page => params[:page].blank? ? 1 : params[:page], :per_page => 5).order(:first_name,:last_name)
    end   
  end

  #To create role
  def create_role
    if !params[:name].blank? and !params[:role_desc].blank?
      @role=AddRole.new(name:params[:name],role_desc:params[:role_desc])
      if @role.save
        resource = params[:resource]
        resource.each{|i| @resource=ManageResource.create(:add_role_id=>@role.id,:resource_id=>i) }
        redirect_to admin_manage_user_path,:notice => "Role Created Successfully"
      end
    end
  end

  #Add role ui action
  def add_roles
    if admin_required?
  	  @resource=Resource.all
    end
  end

  #add an user from admin side
  def create
    if admin_required?
   	  @user=User.find(params[:user_id])
    end
  end
  #Method for deactivate the user 
  def delete_users
    if params[:user_id].present?
      flag=0
      active=User.find(params[:user_id].to_i).is_active
      if active
        flag=1
      else
        flag=0
      end
       active ? User.find(params[:user_id].to_i).update_attribute(:is_active,false) :User.find(params[:user_id].to_i).update_attribute(:is_active,true)
        respond_to do |format|
           format.json {render :json => { :active => flag }}        
        end
    else
        users = params[:users]
      if !users.blank?
        msg=""
        users.each do |u|
          if User.find(u).is_active
            msg="User Deactivate Successfully!"
          else
            msg="User Activate Successfully!"
          end

         end
          
           users.each{|i|  User.find(i).is_active ? User.find(i).update_attribute(:is_active,false) : User.find(i).update_attribute(:is_active,true) }
      end
      redirect_to admin_manage_user_path,:notice => msg
      end
          
    end
   #Method for displaying User edit popup
   def update_user
    if !params[:user_id].blank?
     @user=User.find(params[:user_id])
     if @user.is_customer
     @customer=@user.customers.first
   else
     @employee=@user.employees.first
   end
     respond_to do |format|
      format.js
      format.html
     end
   end
   end

    # def inactive
    #   if !params[:user_id].blank?
    #   @user=User.find(params[:user_id])
    #   @user.is_active=false
    #   @user.save
     
    #   end
    # end
    # Updateing the User
    def update_role
        if !params[:id].blank?
          @role=AddRole.find(params[:id])
          @role.update_attribute(:role_desc,params[:role_desc])
          sql="DELETE FROM manage_resources WHERE add_role_id=#{@role.id};"
          ActiveRecord::Base.connection.execute(sql)
          @role.manage_resources.delete_all
          resource = params[:resource]
          if !resource.blank?
            resource.each{|i| @resource=ManageResource.create(:add_role_id=>@role.id,:resource_id=>i) }
          end
           
        end
        redirect_to admin_role_list_path,:notice => "Update Successfully "
    
    end
  
  # Display Role list
  def role_list
    if admin_required?
   @role=AddRole.order('id ASC') 
   @roles=@role.paginate(:page => params[:page], :per_page => 3)
   if !params[:add_role_id].blank?
    @add_role=AddRole.find(params[:add_role_id])
    if !@add_role.manage_resources.blank?
     @manage=@add_role.manage_resources
    end
    @resource=Resource.all

    render 'edit_role'
    end
   end
  end
  #Update Customer action for admin
  def update_customer
    @customers=User.find(params[:user_id])
       active=params[:active].to_i
          if active==1
           active=true
          else
           active=false
          end
      begin
        @customer=@customers.customers.first
        @customer.update_attributes(address1: params[:address1],address2: nil, zip: params[:zip] ,business:params[:business], city: params[:city], company_name:params[:company_name], county:params[:county], email_1: nil, name: params[:name], phone1:params[:phone1] , phone2:params[:phone2], salutation:params[:salutation], state:params[:state])
        @customers.address=params[:address1].strip
         @customers.update_attributes(is_active: active,first_name:params[:name])
         redirect_to admin_manage_user_path ,:notice=>"Update succesfully!"
      rescue Exception => e
        redirect_to admin_manage_user_path ,:notice=>"#{e.message}"
      end
  end
  #Update Employee action for admin  
  def update_employee
    @employees=User.find(params[:user_id])
    active=params[:active].to_i
          if active==1
           active=true
          else
           active=false
          end
      begin
        @employee=@employees.employees.first
        if employee_params
          
        end
        a=@employee.update_attributes(employee_params)
      
      @employees.address=params[:employee][:address].strip if !params[:employee][:address].blank?
      @employees.save
       if !params[:employee][:doc_or_image].blank?
       
        uploaded_file = params[:employee][:doc_or_image]
        @employee.doc_or_image=uploaded_file.read
        @employee.filename=params[:employee][:doc_or_image].original_filename
        @employee.mime_type=params[:employee][:doc_or_image].content_type
       end
       
       @employee.save
       @employees.is_active=active
       @employees.first_name=params[:employee][:first_name]
       @employees.last_name=params[:employee][:last_name]
       @employees.save
       redirect_to admin_manage_user_path ,:notice=>"Update succesfully!"
       rescue Exception => e
         redirect_to admin_manage_user_path ,:notice=>"#{e.message}"
       end
  end

    private
    # Never trust parameters from the scary internet, only allow the white list through.
    def employee_params
      params.require(:employee).permit(:address,:emp_id,:emp_type,:ref_code,:zip,:user_id,:city, :county, :dob, :email, :first_name, :last_name, :mid_name, :phone, :phone_1, :ss_no, :state,:notes,:devision,:hire_date,:termination_date,:raise_date,:raise_amount)
    end
end
