class User < ActiveRecord::Base
	before_create :confirmation_token
	before_create { generate_token(:auth_token) }

    has_secure_password
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, length: { maximum: 105 }, uniqueness: { case_sensitive: false }, format: { with: VALID_EMAIL_REGEX }
	# validates :password, length: { minimum: 1 }

	before_save do
	  self.email.downcase! if self.email
	end

	def email_activate
      self.email_confirmed = true
      self.confirm_token = nil
      save!(:validate => false)
  	end

	def self.find_for_authentication(conditions) 
	  conditions[:email].downcase! 
	  super(conditions) 
	end

	#For Reset Password
	def send_password_reset
	  generate_token(:password_reset_token)
	  self.password_reset_sent_at = Time.zone.now
	  save!
	  UserMailer.password_reset(self).deliver
	end

	def generate_token(column)
	  begin
	    self[column] = SecureRandom.urlsafe_base64
	  end while User.exists?(column => self[column])
	end

	# Returns true if a password reset has expired.
	def password_reset_expired?
	  password_reset_sent_at < 2.hours.ago
	end

	private
	def confirmation_token
	  if self.confirm_token.blank?
	    self.confirm_token = SecureRandom.urlsafe_base64.to_s
	  end
	end
end
