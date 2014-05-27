class AddRole < ActiveRecord::Base
  attr_accessible :name, :role_desc
  has_many :manage_resources
end
