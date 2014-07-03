class PasswordsController < Devise::PasswordsController 
  prepend_before_filter :require_no_authentication
  append_before_filter :assert_reset_token_passed, :only => :edit

  def new
    super
  end

  def create
    self.resource = resource_class.send_reset_password_instructions(resource_params)
    if successfully_sent?(resource)
      render :json=>{:message=>"Congratulations! Password reset mail is sent to your account."},:status=>201
    else
      render :json=>resource ,:status=>401
    end
  end

  def edit
    super
  end

  def update
    self.resource = resource_class.reset_password_by_token(resource_params)
    if resource.errors.empty?
      resource.unlock_access! if unlockable?(resource)
      flash_message = resource.active_for_authentication? ? :updated : :updated_not_active
      set_flash_message(:notice, flash_message) if is_navigational_format?
      sign_in(resource_name, resource)
      redirect_to login_path, :notice => "Password has been change"
    else
      respond_with resource
    end
  end

  def edit_password_em
    original_token       = params[:user][:reset_password_token]
    reset_password_token = Devise.token_generator.digest(self, :reset_password_token, original_token)
    @user= User.where(:reset_password_token=>reset_password_token)
    if @user.empty?
      render :status => 200, :json => { :error => "Reset token is expired or not valid!" }
    else
      if params[:user][:password]==params[:user][:password_confirm]
        @user.first.update(user_params)
        render :status => 200, :json => { :success => "congratulations! Your password is changed." ,:status=>201}
      else
        render :status => 200, :json => { :password_e => "Password mismatch!!" }
      end
    end
  end

  protected

    def after_sending_reset_password_instructions_path_for(resource_name)
      root_path
    end

    def assert_reset_token_passed
      super
    end

    def unlockable?(resource)
      super
    end

    def user_params
      params.require(:user).permit(:password,:reset_password_token)
    end

end