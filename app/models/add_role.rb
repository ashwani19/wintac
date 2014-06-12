#Class is use to manage role and add new role from admin side
class AddRole < ActiveRecord::Base
  attr_accessible :name, :role_desc
  has_many :manage_resources
end
