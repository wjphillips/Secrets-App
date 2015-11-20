class UsersController < ApplicationController
	before_action :require_login, except: [:new, :create]
	before_action :require_correct_user, only: [:show, :edit, :update, :destroy]
	def new
	end
	def show
		@user = User.find(params[:id])
		@secrets = @user.secrets
	end
	def edit
		@user = User.find(session[:user_id])
	end
	def create
		flash[:errors] = []
		user = User.create(name: params[:name], email: params[:email], password: params[:password], password_confirmation: params[:password_confirmation])
		if user.save
			flash[:errors].push("Successful Registration!")
			user = User.last
			session[:user_id] = user.id
			session[:log_in] = true
			redirect_to "/users/#{user.id}"
		else
			if user.errors.any?
				flash[:errors] = user.errors.full_messages
				redirect_to "/users/new"
			end
		end	
	end
	def update
		flash[:errors] = []
		user = User.find(session[:user_id])
		if params[:password].blank?
			params.delete(:password)
			params.delete(:password_confirmation)
		end
		if user.update(name: params[:name], email: params[:email])
			flash[:errors].push("Profile Updated Successfully")
			redirect_to "/users/#{user.id}"
		else
			if user.errors.any?
				flash[:errors] = user.errors.full_messages
				redirect_to "/users/#{user.id}/edit"
			end
		end
	end
	def destroy
		user = User.find(session[:user_id])
		user.destroy!
		session[:user_id] = nil
		session[:log_in] = false
		redirect_to "/sessions/new"
	end
end