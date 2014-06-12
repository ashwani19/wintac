#Employee model use for manage employee table
class Employee < ActiveRecord::Base
  #attr_accessible :address,:emp_id,:emp_type,:ref_code,:zip,:user_id,:city, :county, :dob, :email, :first_name, :last_name, :mid_name, :phone, :phone_1, :ss_no, :state
  belongs_to :user
  has_many :employee_identifications
  has_many :payroll_informations
  before_update :ss_no_encrypt
   attr_accessor :ss_no
@@crypt = ActiveSupport::MessageEncryptor.new(Rails.configuration.secret_key_base)
def ss_no_encrypt
	if ss_no.present? 
     ssn_hash = @@crypt.encrypt_and_sign(ss_no)
     self.ss_no_enc=ssn_hash
     
   end
end
public
def ss_no_dec
	@@crypt.decrypt_and_verify(ss_no_enc)
end

end