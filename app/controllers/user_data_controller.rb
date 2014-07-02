class UserDataController < ApplicationController
  load_and_authorize_resource :class=>false
  def index
    @users=User.where("user_type !='admin'").order("first_name asc")
    render json: @users,status: 201
  end

  def search_users
    if params[:search_type]=="active"
      user_list = User.where("is_active=?",true)
      render :status => 200, :json => user_list
    elsif params[:search_type]=="inactive"
      user_list = User.where("is_active=?",false)
      render :status => 200, :json => user_list
    elsif !params[:search_word].blank?
      if params[:search_type]=="name"
        user_list = User.where("first_name iLIKE ?","#{params[:search_word]}%")
        render :status => 200, :json => user_list
      elsif params[:search_type]=="address"
        user_list = User.where("address iLIKE ?","#{params[:search_word]}%")
        render :status => 200, :json => user_list
      elsif params[:search_type]=="role"
        user_list = User.where("user_type iLIKE ?","#{params[:search_word]}%")
        render :status => 200, :json => user_list
      end
    else
      @users=User.all
      render :json=> @users,:status=> 201
    end
  end
  #for single use active or inactive
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
   @user.address=params[:customer][:address1]
   @user.first_name=params[:customer][:first_name]
   @user.last_name=params[:customer][:last_name]
   @customer.name=params[:customer][:first_name]
   @user.save
   @customer.save
   end
   render :json=>@customer

  end
  #For multipal user active or inactive
  def user_active
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
      @users=User.where("user_type!='admin'").order("first_name asc")
      render :json=>@users
  end
  def sorting
    order= params[:order]
    sort_by=params[:sort_by]
    @users=User.where("user_type!='admin'").order("#{sort_by} #{order}")
    render :json=>@users
  end
  private

  def customer_params
    params.require(:customer).permit(:name,:address1,:state,:city,:business,:company_name,:phone1,:phone2,:salutation,:county,:zip)

  end
end
