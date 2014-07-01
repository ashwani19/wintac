class EmployeeSerializer < ActiveModel::Serializer
  attributes :id,:address,:emp_id,:filename,:emp_type,:ref_code,:zip,:user_id,:city, :county, :dob, :email, :first_name, :last_name, :mid_name, :phone, :phone_1, :ss_no, :state,:notes,:devision,:hire_date,:termination_date,:raise_date,:raise_amount
end
