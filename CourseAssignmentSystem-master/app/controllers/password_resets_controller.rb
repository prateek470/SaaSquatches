class PasswordResetsController < ApplicationController
	before_action :get_user,   only: [:edit, :update]
  	before_action :valid_user, only: [:edit, :update]
  	before_action :check_expiration, only: [:edit, :update]

	def new
	end

	def create
		@user = User.find_by(email: params[:password_reset][:email].downcase)
	    if @user
	      @user.send_password_reset
	      flash[:info] = "Email sent with password reset instructions"
	      redirect_to root_url
	    else
	      flash.now[:danger] = "Email address not found"
	      render 'new'
	    end
	end

	def edit
	  @user = User.find_by_password_reset_token!(params[:id])
	end

	def update
		if params[:user][:password].empty?                  # Case (3)
	      @user.errors.add(:password, "can't be empty")
	      render 'edit'
	    elsif @user.update_attributes(user_params)
	      @user.update_attribute(:password_reset_token, nil)
	      flash[:success] = "Password has been reset."
	      redirect_to '/login'
	    else
	      render 'edit'                                     # Case (2)
	    end
	end

	private

	def user_params
      params.require(:user).permit(:password, :password_confirmation)
    end

    def get_user
      @user = User.find_by(email: params[:email])
    end

    # Confirms a valid user.
    def valid_user
      unless (@user && @user.email_confirmed?)
        redirect_to root_url
      end
    end

    # Checks expiration of reset token.
    def check_expiration
      if @user.password_reset_expired?
        flash[:danger] = "Password reset has expired."
        redirect_to new_password_reset_url
      end
    end
end
