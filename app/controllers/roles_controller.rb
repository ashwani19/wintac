class RolesController < ApplicationController
	def index
		@roles =Role.all
		render :json=> @roles
	end

	def create
		role =Role.new(role_params)
		if role.save
			render :json=>{:message=> "Congratulations! Role created", :status=>201}
		else
			render :json=>{:message=> "Sorry try later", :status=>401}
		end	
	end

	def edit
		role= Role.where(:id=> params[:id]).first
		render :json=>{:role=> role}
	end	

	def update
		role= Role.update(params[:id],role_params)
		if role.save
			render :json=>{:message=> "Congratulations! Role updated", :status=>201}
		else
			render :json=>{:message=> "Sorry try later", :status=>401}
		end	
	end

	def search_roles
		if !params[:search_word].blank?
			if params[:search_type]=="name"
				role_list = Role.where("name LIKE ?","#{params[:search_word]}%")
				render :status => 200, :json => {:role_list=> role_list}
			elsif params[:search_type]=="description"
				role_list = Role.where("description LIKE ?","#{params[:search_word]}%")
				render :status => 200, :json => {:role_list=> role_list}
			end
		else
			@roles =Role.alls
			render :json=>{:role_list=> @roles}
		end
	end
	private
	
	def role_params
		params.require(:role).permit(:name, :description)
	end
end
