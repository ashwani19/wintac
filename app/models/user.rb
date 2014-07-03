class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable
  has_one :customer
  has_one :employee

  validates :first_name,:email,:password, :presence=>{ :message => " should be present" }
  validates :password, :confirmation => { :message => " passwords should match" }, length: { in: 6..20, too_short: "should be atleast 6 characters long" }
  validates :email, :uniqueness=> { :message => " should be unique" }, :email=> { :message => " should be in email format" }

   def before_add_method(role)
   		self.add_role "#{role}"
 	end
end
