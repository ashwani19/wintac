#Custome model use for manage customer table
class Customer < ActiveRecord::Base
  attr_accessible :address1, :zip,:user_id,:address2, :business, :city, :company_name, :county, :email, :email_1, :name, :phone1, :phone2, :salutation, :state
  belongs_to :user
  validates :email, presence: true, uniqueness: true, strict:true
end
