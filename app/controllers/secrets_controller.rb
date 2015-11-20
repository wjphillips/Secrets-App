class SecretsController < ApplicationController
	before_action :require_login, only: [:index, :create, :destroy]
	def index
		@secrets = Secret.all.reverse_order
		@users = User.all
	end
	def create
		@secret = User.find(session[:user_id]).secrets.new
		@secret.content = params["New Secret"]
		@secret.save
		redirect_to "/users/#{current_user.id}"
	end
	def destroy
		secret = Secret.find(params[:id])
		secret.destroy if secret.user == current_user
		redirect_to "/users/#{current_user.id}"
	end
	def like
		like = Like.new
		like.user_id = session[:user_id]
		like.secret_id = params[:secret_id]
		like.save
		redirect_to "/secrets"
	end
	def unlike
		like = Like.find_by(user_id: session[:user_id], secret_id: params[:secret_id])
		like.destroy
		redirect_to "/secrets"
	end
end