class JsonSessionsController < Devise::SessionsController

  def create
    warden.authenticate!(:scope => resource_name, :recall => "#{controller_path}#new")
    params[:user].merge!(:remember_me=> true)
    user = Hash.new
    user["email"] ="#{current_user.email}"
    user["id"] ="#{current_user.id}"
    user["role"] ="#{current_user.roles.first.name}"
    user["first_name"]=current_user.first_name
        #user.to_json
        render :status => 200, :json => { :error => "Success" ,:user=> user}


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
            user_list = User.where("first_name LIKE ?","#{params[:search_word]}%")
            render :status => 200, :json => user_list
          elsif params[:search_type]=="address"
            user_list = User.where("address LIKE ?","#{params[:search_word]}%")
            render :status => 200, :json => user_list
          elsif params[:search_type]=="role"
            user_list = User.where("user_type LIKE ?","#{params[:search_word]}%")
            render :status => 200, :json => user_list
          end
        else
          @users=User.all
          render :json=> @users,:status=> 201
        end

      end

      def destroy
        signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
        render :json=> {
          'csrf-param' => request_forgery_protection_token,
          'csrf-token' => form_authenticity_token
        }
      end
    end