class UserSerializer < ActiveModel::Serializer
  has_one :customer
  has_one :employee
  attributes :id,:address,:first_name,:user_type,:is_active,:created_at,:email

end
