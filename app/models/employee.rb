class Employee < ActiveRecord::Base
  belongs_to :user
  has_one :employee_identification
  has_one :payroll_information
   
end
