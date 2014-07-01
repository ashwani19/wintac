class UserDataController < ApplicationController
  respond_to :json
  def index

    @users=User.where("user_type !='admin'")


    render json: @users,status: 201
  end
  def shod
    respond_with :json
  end
  def active_user
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
    end
  	
  end
  def edit_user
    @user=User.find(params[:user_id])
    if @user.user_type=='customer'
        #@user=User.select("users.created_at as created_at, users.user_type as user_type,users.is_active as is_active,users.email as email,users.id as id,users.first_name as first_name ,users.last_name as last_name,users.addres as addres,customers.company_name as company_name,customers.city as city,customers.zip as zip,customers.state as state,customers.phone1 as phone1 ").joins("INNER JOIN customers on customers.user_id=users.id").where(" users.id=#{params[:user_id]}").first
        @user=User.joins(:customer).where(:id=>params[:user_id]).first
    elsif @user.user_type=='employee'
      #@user=User.select("users.created_at as created_at, users.user_type as user_type,users.is_active as is_active,users.email as email,users.id as id,users.first_name as first_name ,users.last_name as last_name,users.addres as addres,employees.city as city,employees.zip as zip,employees.state as state,employees.phone as phone ").joins("INNER JOIN employees on employees.user_id=users.id").where(" users.id=#{params[:user_id]}").first
        @user=User.joins(:employee).where(:id=>params[:user_id]).first
    end
    render :json=> @user
  end
  def update_user
    @user=User.find(params[:user_id])
      @customer=Customer.where(:user_id=>params[:user_id]).last

   if @customer.update(customer_params)
   @user.addres=params[:customer][:address1]
   @user.first_name=params[:first_name]
   @user.last_name=params[:last_name]
   @user.save
   end
   render :json=>@customer

  end
  private

  def customer_params
    params.require(:customer).permit(:name,:address1,:state,:city,:business,:company_name,:phone1,:phone2,:salutation,:county)

  end
end
