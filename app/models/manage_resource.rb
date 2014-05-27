class ManageResource < ActiveRecord::Base
  attr_accessible :resource_id, :add_role_id, :user_id
  belongs_to :add_role
end
