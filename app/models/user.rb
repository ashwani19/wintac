class User < ActiveRecord::Base
  rolify
  attr_accessible :email,:is_active ,:password,:address,:account,:password_confirmation, :first_name,:last_name,:user_type,:auth_token,:password_reset_token ,:password_reset_sent_at
  
  attr_accessor :password
  before_save :encrypt_password
  before_create { generate_token(:auth_token) }
  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates_presence_of :email
  validates_uniqueness_of :email
  belongs_to :users_role
  has_many :customers
  has_many :employees
# Add Role for user
  	def before_add_method(role)
  		if role=="admin"
  			self.add_role :admin
  	    elsif role=="customer"
  	    	self.add_role :customer
  	    elsif role=="employee"
  	    	self.add_role :employee
    	end
  	end

# Authenticate the user
  	def self.authenticate(email,password)
    	user = find_by_email(email)
    	if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      		user
    	else
      		nil
    	end
  	end

# Encrypt the password
  	def encrypt_password
    	if password.present?
      		self.password_salt = BCrypt::Engine.generate_salt
      		self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    	end
  	end

# Password reset
 	def send_password_reset
  		generate_token(:password_reset_token)
  		self.password_reset_sent_at = Time.zone.now
  		save!
  		begin
  			UserMailer.password_reset(self).deliver	
  		rescue Exception => e
  			puts "====================>#{e.message}"
  		end
  
 	end

# Genrate user token
 	def generate_token(column)
  		begin
    		self[column] = SecureRandom.urlsafe_base64
  		end while User.exists?(column => self[column])
 	end

# Display Full Name of company or user
 	def full_name
		self.first_name.capitalize+" "+self.last_name.capitalize if !self.first_name.nil? and !self.last_name.nil?
  	end
 def is_admin
   if self.user_type=="admin"
     true
   else
    false
   end
 end
 def is_customer
   if self.user_type=="customer"
     true
   else
    false
   end
 end
 def is_employee
   if self.user_type=="employee"
     true
   else
    false
   end
 end

end
