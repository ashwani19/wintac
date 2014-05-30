class SearchController < ApplicationController
	#user search  code 
  def search_user
	   @user ||= fetch_users
  	    respond_to do |format|
         format.js
  	    end
			
	end
  
  def search_role
    @roles ||= fetch_roles
    
    respond_to do |format|
         format.js
        end
  end
#start sorting code
def fetch_users
    users = User.where("user_type!='admin'").order("#{sort_column_user} #{sort_direction}")
    users = users.page(page).per_page(per_page)
    if params[:keyword].present?
      users = users.where("first_name iLIKE :search or address iLIKE :search or user_type iLIKE :search and user_type!='admin'", search: "#{params[:keyword]}%")
    end
    users
  end

  def page
       page_no=params[:page]
       if !page_no.blank? and page_no.to_i==1
           displayStart=0
        else
          displayStart=(page_no.to_i-1)*per_page
       end

     displayStart/per_page+1
   # params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
   params[:per_page].to_i
  end

  def sort_column_user
    columns = %w[first_name address user_type created_at]
    columns[params[:order].to_i]
  end

  def sort_direction
   params[:desc]
  end

#role search code
def fetch_roles
    roles=AddRole.order("#{sort_column_role} #{sort_direction}")
    roles = roles.page(page).per_page(per_page)
    if params[:keyword].present?
      roles = roles.where("name iLIKE :search or role_desc iLIKE :search", search: "#{params[:keyword]}%")
    end
    roles
  end

def sort_column_role
    columns = %w[name role_desc created_at]
    columns[params[:order].to_i]
  end
#end role search and sort

	
end
