class AdminController < ApplicationController
 #Manage user ui page action
  def manage_user
  	if !current_user.nil? && current_user.user_type=="admin"
      	@user=User.where(:is_active=>true).order('id ASC')
    else
    	redirect_to root_url
   end
end
#To create role
def create_role
  if !current_user.nil? and current_user.is_admin
   if !params[:name].blank? and !params[:role_desc].blank?
     @role=AddRole.new(name:params[:name],role_desc:params[:role_desc])
     if @role.save
      resource = params[:resource]
      resource.each{|i| @resource=ManageResource.create(:add_role_id=>@role.id,:resource_id=>i) }
      redirect_to admin_manage_user_path,:notice => "Role Created Successfully"
     end
   end
  end
end
#Add role ui action
def add_roles
	if !current_user.nil? && current_user.is_admin
		
		@resource=Resource.all
	else
    	redirect_to root_url
   end
end
#add an user from admin side
 def create
 	 @user=User.find(params[:user_id])
 end

#Methode is depricated and is not use current
 def resource_update
  result=ManageResource.all
  if result.blank?
  sql = "TRUNCATE TABLE manage_resources RESTART IDENTITY;"
  records_array = ActiveRecord::Base.connection.execute(sql)
  end
  @user_id=params[:user_id]
  @resource_id=params[:resource_id]
  chacked=params[:is_chacked]
  
  if chacked=="false"
      @manage= ManageResource.find_by_user_id_and_resource_id(params[:user_id],params[:resource_id])
      @manage.delete
  else
    @manage= ManageResource.find_by_user_id_and_resource_id(params[:user_id],params[:resource_id])
    if @manage.nil?
      @role=ManageResource.create(:user_id=>@user_id,:resource_id=>params[:resource_id])
    end
  end
  
   respond_to do |formate|
    formate.html
    formate.js
   end
 end
 #End depricated method
 
 def delete_users
      users = params[:users]
        if !users.blank?
         users.each{|i| User.find(i).update_attribute(:is_active,false) }
        end
        redirect_to admin_manage_user_path,:notice => "User Deleted Successfully!"
  end
 #show user delete popup
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
  def inactive
    if !params[:user_id].blank?
    @user=User.find(params[:user_id])
    @user.is_active=false
    @user.save
   
    end
  end
  def update_role
     if !current_user.nil? and current_user.is_admin
      if !params[:id].blank?
        puts "=============================#{params[:id]}"
        @role=AddRole.find(params[:id])
        @role.update_attribute(:role_desc,params[:role_desc])
        sql="DELETE FROM manage_resources WHERE add_role_id=#{@role.id};"
        ActiveRecord::Base.connection.execute(sql)
        @role.manage_resources.delete_all
        resource = params[:resource]
        if !resource.blank?
         resource.each{|i| @resource=ManageResource.create(:add_role_id=>@role.id,:resource_id=>i) }
        end
        redirect_to admin_role_list_path,:notice => "Update Successfully "
      end
  end
  end
  def role_list
   @roles=AddRole.all(order: 'id ASC') 
   if !params[:add_role_id].blank?
    @add_role=AddRole.find(params[:add_role_id])
    if !@add_role.manage_resources.blank?
     @manage=@add_role.manage_resources
    end
    @resource=Resource.all

    render 'edit_role'
   end
  end
  def update_customer
    @user=User.find(params[:user_id])
      begin
        @customer=@user.customers.first
        @customer.update_attributes(address1: params[:address1],address2: nil, business:params[:business], city: params[:city], company_name:params[:company_name], county:params[:county], email_1: nil, name: params[:name], phone1:params[:phone1] , phone2:params[:phone2], salutation:params[:salutation], state:params[:state])
        redirect_to admin_manage_user_path ,:notice=>"Update succesfully!"
      rescue Exception => e
        redirect_to admin_manage_user_path ,:notice=>"#{e.message}"
      end
  end
  def update_employee
    @user=User.find(params[:user_id])
      begin
        @employee=@user.employees.first
        @employee.update_attributes(address: params[:address],zip:params[:zip],first_name:params[:first_name],ref_code:params[:ref_code], dob: nil,city: params[:city], last_name:params[:last_name], county:params[:county],mid_name: params[:mid_name], phone_1:params[:phone_1] , phone:params[:phone], ss_no:params[:ss_no], state:params[:state])
         if !params[:dob].blank?
          @employee.dob= params[:dob].to_date
        end
         @employee.save
        current_user.first_name=params[:first_name]
        current_user.last_name=params[:last_name]
        current_user.save
        redirect_to admin_manage_user_path ,:notice=>"Update succesfully!"
      rescue Exception => e
        redirect_to admin_manage_user_path ,:notice=>"#{e.message}"
      end
  end
end
