#Class use to manage the custmomer
class CustomersController < ApplicationController

 #skip_before_filter  :verify_authenticity_token
 skip_before_filter :verify_authenticity_token, :if => Proc.new { |c| c.request.format == 'application/json' }
  # Customer Home page
  def customer_home
  if customer_required?
    @customer=User.find(current_user.id).customers.first
  end
  end
  def customer_profile
    if customer_required?
      @customer=User.find(current_user.id).customers.first
    end
  end
  # Update customer row data
  def update_row
    if customer_required?
      @user=User.find(current_user.id)
      begin
        @customer=@user.customers.first
        #@customer.update_attributes(address1: params[:address1].strip,address2: nil,zip:params[:zip], business:params[:business], city: params[:city], company_name:params[:company_name], county:params[:county], email_1: nil, name: params[:name], phone1:params[:phone1] , phone2:params[:phone2], salutation:params[:salutation], state:params[:state])
        @customer.update_attributes(employee_params)
        @user.address=params[:customer][:address1].strip
        @user.save
        redirect_to customers_customer_home_path ,:notice=>"Update succesfully!"
      rescue Exception => e
        redirect_to customers_customer_update_path ,:notice=>"#{e.message}"
      end
    end
  end
  # customer update page action 
  def customer_update
    
    if customer_required?
      @customer=current_user.customers.first
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

  private
    

    # Never trust parameters from the scary internet, only allow the white list through.
    def employee_params
      params.require(:customer).permit(:address1, :zip,:user_id,:address2, :business, :city, :company_name, :county, :email, :email_1, :name, :phone1, :phone2, :salutation, :state)
    end
end
