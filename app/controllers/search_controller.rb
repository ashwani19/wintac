class SearchController < ApplicationController
	#user search  code 
  def search_user
	   keyword=params[:keyword]
  	   order=params[:order]
       desc=params[:desc]
  	   case order
  	    when "name"
  	    	if keyword.blank?
            if !desc.blank?
              @user=User.where("user_type!='admin'").page( params[:page].blank? ? 1 : params[:page]).per_page(10).reorder("first_name DESC")
            else
              @user=User.where("user_type!='admin'").page( params[:page].blank? ? 1 : params[:page]).per_page(10).reorder(:first_name,:last_name)
            end
  	    	else
            if !desc.blank?
  	    		  @user=User.where("first_name iLIKE ? and user_type!='admin'","#{keyword}%").page( params[:page].blank? ? 1 : params[:page]).per_page(10).reorder("first_name DESC")
  	    		else
              @user=User.where("first_name iLIKE ? and user_type!='admin'","#{keyword}%").page( params[:page].blank? ? 1 : params[:page]).per_page(10).reorder(:first_name,:last_name)
            end
  	    	end 
  	    when "date"
  	    	if keyword.blank?
            if !desc.blank?
              @user=User.where("user_type!='admin'").page( params[:page].blank? ? 1 : params[:page]).per_page(10).reorder("created_at DESC")
            else
              @user=User.where("user_type!='admin'").page( params[:page].blank? ? 1 : params[:page]).per_page(10).reorder(:created_at)
            end
  	    		
  	    	else
            if !desc.blank?
  	    		  @user=User.where("first_name iLIKE ? and user_type!='admin'","#{keyword}%").page( params[:page].blank? ? 1 : params[:page]).per_page(10).reorder('created_at DESC')
  	    		else
              @user=User.where("first_name iLIKE ? and user_type!='admin'","#{keyword}%").page( params[:page].blank? ? 1 : params[:page]).per_page(10).reorder(:created_at)
            end
  	    	end
  	    when "address"
  	    	if keyword.blank?
            if !desc.blank?
              @user=User.where("user_type!='admin'").page( params[:page].blank? ? 1 : params[:page]).per_page(10).reorder("address DESC")
            else
              @user=User.where("user_type!='admin'").page( params[:page].blank? ? 1 : params[:page]).per_page(10).reorder(:address)
            end
  	    		
  	    		#@user=@users.paginate(:page => params[:page].blank? ? 1 : params[:page], :per_page => 10)
  	    	else
            if !desc.blank?
  	    		 @user=User.where("first_name iLIKE ? and user_type!='admin'","#{keyword}%").page( params[:page].blank? ? 1 : params[:page]).per_page(10).reorder('address DESC')
            else
              @user=User.where("first_name iLIKE ? and user_type!='admin'","#{keyword}%").page( params[:page].blank? ? 1 : params[:page]).per_page(10).reorder('address ASC')
           end
  	    		#@user=@users.paginate(:page => params[:page].blank? ? 1 : params[:page], :per_page => 10)
  	    	end
  	    when "role"
  	        if keyword.blank?
              if !desc.blank?
              @user=User.where("user_type!='admin'").page( params[:page].blank? ? 1 : params[:page]).per_page(10).reorder("user_type DESC")
            else
              @user=User.where("user_type!='admin'").page( params[:page].blank? ? 1 : params[:page]).per_page(10).reorder(:user_type)
            end
  	        else
              if !desc.blank?
                @user=User.where("first_name iLIKE ? and user_type!='admin'","#{keyword}%").page( params[:page].blank? ? 1 : params[:page]).per_page(10).reorder('user_type DESC')
              else
                @user=User.where("first_name iLIKE ? and user_type!='admin'","#{keyword}%").page( params[:page].blank? ? 1 : params[:page]).per_page(10).reorder('user_type ASC')
              end
  	        	
  	        	#@user=@users.paginate(:page => params[:page].blank? ? 1 : params[:page], :per_page => 10)
  	        end
          when "active"
            if keyword.blank?
              if !desc.blank?
              @user=User.where("is_active=? and user_type!='admin'",true).page( params[:page].blank? ? 1 : params[:page]).per_page(10).reorder("first_name DESC")
            else
              @user=User.where("is_active=? and user_type!='admin'",true).page( params[:page].blank? ? 1 : params[:page]).per_page(10).reorder(:first_name,:last_name)
            end
            else
              if !desc.blank?
                @user=User.where("is_active=? and first_name iLIKE ? and user_type!='admin'",true,"#{keyword}%").page( params[:page].blank? ? 1 : params[:page]).per_page(10).reorder("first_name DESC")
              else
                 @user=User.where("is_active=? and first_name iLIKE ? and user_type!='admin'",true,"#{keyword}%").page( params[:page].blank? ? 1 : params[:page]).per_page(10).reorder(:first_name,:last_name)
              end
              
              #@user=@users.paginate(:page => params[:page].blank? ? 1 : params[:page], :per_page => 10)
            end

          when "deactive"
             if keyword.blank?
              if !desc.blank?
              @user=User.where("is_active=? and user_type!='admin'",false).page( params[:page].blank? ? 1 : params[:page]).per_page(10).reorder("first_name DESC")
            else
              @user=User.where("is_active=? and user_type!='admin'",false).page( params[:page].blank? ? 1 : params[:page]).per_page(10).reorder(:first_name,:last_name)
            end
            else
              if !desc.blank?
                 @user=User.where("is_active=? and first_name iLIKE ? and user_type!='admin'",false,"#{keyword}%").page( params[:page].blank? ? 1 : params[:page]).per_page(10).reorder('first_name desc')
              else
                 @user=User.where("is_active=? and first_name iLIKE ? and user_type!='admin'",false,"#{keyword}%").page( params[:page].blank? ? 1 : params[:page]).per_page(10).reorder(:first_name,:last_name)
              end
             
              #@user=@users.paginate(:page => params[:page].blank? ? 1 : params[:page], :per_page => 10)
            end
              
  	    							
  	    end 
  	    respond_to do |format|
         format.js
  	    end
			
	end
#role search code
	def search_role
		keyword=params[:keyword]
  	   order=params[:order]
      desc= params[:desc]
  	   case order
  	   when "name"
         if keyword.blank?
          if !desc.blank?
         	  @roles=AddRole.page( params[:page].blank? ? 1 : params[:page]).per_page(6).reorder('name desc') 
          else
            @roles=AddRole.page( params[:page].blank? ? 1 : params[:page]).per_page(6).reorder(:name) 
          end
         else
         	@roles=AddRole.where('name iLIKE ?',"#{keyword}%").page( params[:page].blank? ? 1 : params[:page]).per_page(6).reorder("name ASC")
         	#@roles=@role.paginate(:page =>params[:page].blank? ? 1 : params[:page], :per_page => 6)
         end
  	   when "date"
  	   if keyword.blank?
        if !desc.blank?
          @roles=AddRole.page( params[:page].blank? ? 1 : params[:page]).per_page(6).reorder('created_at desc') 
        else
  	   	     @roles=AddRole.page( params[:page].blank? ? 1 : params[:page]).per_page(6).reorder(:created_at) 
         end   
  	   else
  	   	     @roles=AddRole.where('name iLIKE ?',"%#{keyword}%").page( params[:page].blank? ? 1 : params[:page]).per_page(6).reorder("created_at ASC")
             #@roles=@role.paginate(:page => params[:page].blank? ? 1 : params[:page], :per_page => 6)
  	   end
  	   			
  	   end
		respond_to do |format|
         format.js
  	    end
	end
end
