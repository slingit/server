module Api
	module V1
		class MessagesController < ApplicationController

			def create
				message = current_device.messages.create(message_params)
				message.deliver
				render nothing: true, status: :created
			end

			private

			def message_params
				params.require(:message).permit(:content)
			end

		end
	end
end
