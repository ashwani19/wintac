class PayrollInformation < ActiveRecord::Base
  attr_accessible :employee_id, :hired_date, :notes, :raise_amount, :raise_date, :termin_date
  
  belongs_to :employee
end
