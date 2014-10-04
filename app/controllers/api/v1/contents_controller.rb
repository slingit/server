module Api
	module V1
		class ContentsController < ApplicationController

			def show
				message = Message.find(params[:message_id])
				render plain: message.content
			end

		end
	end
end