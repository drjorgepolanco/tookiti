class AccountActivationsController < ApplicationController

	def edit
		user = User.find_by(email: params[:email])
		if user and !user.activated? and user.authenticated?(:activation, params[:id])
			user.activate
			log_in(user)
			flash[:success] = 'account activated!'
			redirect_to(user)
		else
			flash[:warning] = 'invalid activation link'
			redirect_to(root_url)
		end
	end
	
end
