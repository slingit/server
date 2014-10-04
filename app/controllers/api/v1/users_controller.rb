module Api
	module V1
		class UsersController < ApplicationController
			def create
				Group.find_or_create_by!(id: user_params[:group_id])
				@user = User.create!(user_params)
				render nothing: true, status: :created
			end

			private

			def user_params
				params.require(:user).permit(:id, :group_id)
			end
		end
	end
end