module Api
	module V1
		class DevicesController < ApplicationController

			def create
				Group.find_or_create_by!(id: device_params[:group_id])
				Device.create!(device_params)
				render nothing: true, status: :created
			end

			private

			def device_params
				params.require(:device).permit(:id, :group_id, :token, :type)
			end

		end
	end
end