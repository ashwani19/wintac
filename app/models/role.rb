class Role < ActiveRecord::Base
  has_and_belongs_to_many :users, :join_table => :users_roles
  belongs_to :resource
  
  scopify
  # attr_accessible :title, :body
	 #  def self.create_batch_role
	 #  	[:admin, :author, :contact, :user].each do |role|
	 #  		Role.find_or_create_by_name({ name: role }, without_protection: true)
		# end
		# @user.add_role :admin
		# @user.has_role? :admin
	 #  end
  		
end
