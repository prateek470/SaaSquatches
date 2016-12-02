class User < ActiveRecord::Base
	before_create :confirmation_token

    has_secure_password
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, length: { maximum: 105 }, uniqueness: { case_sensitive: false }, format: { with: VALID_EMAIL_REGEX }
	validates :password, length: { minimum: 1 }

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

	private
	def confirmation_token
	  if self.confirm_token.blank?
	    self.confirm_token = SecureRandom.urlsafe_base64.to_s
	  end
	end
end
