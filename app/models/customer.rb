class Customer < ActiveRecord::Base
  attr_accessible :address1, :zip,:user_id,:address2, :business, :city, :company_name, :county, :email, :email_1, :name, :phone1, :phone2, :salutation, :state
  belongs_to :user
end
