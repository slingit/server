module Api
	module V1
		class ContentsController < ApplicationController

			def show
				message = Message.find(params[:message_id])
				path = "public/uploads/messages/#{message.id}/content"
				if message.content_type == 'text/x-hyperlink'
					redirect_to open(path).read
				else
					send_file Rails.root.join(path), type: message.content_type, disposition: :inline
				end
			end

		end
	end
end