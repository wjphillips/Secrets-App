class SessionsController < ApplicationController
	def index
		render 'sessions/new'
	end
	def create
		@user = User.find_by(email: params[:email]).try(:authenticate, params[:password])
		if @user
			session[:user_id] = @user.id
			session[:log_in] = true
			redirect_to "/users/#{@user.id}"
		else
			flash[:error] = "Invalid Email/Password combination. Please try again."
			redirect_to "/sessions/new"
		end
	end
	def destroy
		session[:user_id] = nil
		session[:log_in] = false
		redirect_to "/sessions/new"
	end
end