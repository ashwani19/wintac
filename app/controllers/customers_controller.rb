class CustomersController < ApplicationController

  respond_to :html, :json
  # Customer Home page
  def customer_home
  @customer=User.find(current_user.id).customers.first
  end
  def customer_profile
     @customer=User.find(current_user.id).customers.first
  end
  # Update customer row data
  def update_row
    
      @user=User.find(current_user.id)
      begin
        @customer=@user.customers.first
        @customer.update_attributes(address1: params[:address1],address2: nil, business:params[:business], city: params[:city], company_name:params[:company_name], county:params[:county], email_1: nil, name: params[:name], phone1:params[:phone1] , phone2:params[:phone2], salutation:params[:salutation], state:params[:state])
        redirect_to customers_customer_home_path ,:notice=>"Update succesfully!"
      rescue Exception => e
        redirect_to customers_customer_update_path ,:notice=>"#{e.message}"
      end
  end
  # customer update page action 
  def customer_update
    if !current_user.nil?
      @customer=current_user.customers.first
      
      else
        redirect_to root_url, :notice => "Please Sign in!"
    end
  end

  # Customer create action
  def create
      @user = User.new(params[:user])
      @user.user_type=params[:role]
      @user.before_add_method(params[:role])
      @customer=Customer.new(name: @user.full_name,user_id: @user.id,email: @user.email)
      @customer.transaction do
        if @user.save
           @customer.user_id=@user.id
           @customer.save
  	         cookies[:auth_token] =  @user.auth_token
  	       begin  
             UserMailer.welcome_mail(@user).deliver
	         rescue Exception =>e
	           puts "=================>#{e.message}" 
          end
  	
          redirect_to  customers_customer_update_path, :notice => "Signed up!"
        else
          render "new"
        end

      end
    end
    
    
  def add_job
    
  end
  #method for inline editing  
  def update
      @customer=Customer.find(params[:id])
      @customer.update_attributes(params[:customer])
      respond_with @customer
  end
end
