class Employee < ActiveRecord::Base
  attr_accessible :address, :ref_code,:zip,:user_id,:city, :county, :dob, :email, :first_name, :last_name, :mid_name, :phone, :phone_1, :ss_no, :state
  belongs_to :user
  has_many :employee_identifications
  has_many :payroll_informations
end
