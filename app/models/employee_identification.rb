class EmployeeIdentification < ActiveRecord::Base
  attr_accessible :division, :employee_id, :location, :type_id
  belongs_to :employee
end
