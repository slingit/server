module Api
	module V1
		class MessagesController < ApplicationController

			def create
				content = message_params["content"]
				# binding.pry
				message = (current_device || GoogleDevice.last).messages.new(message_params.except(:content))
				if content.is_a? ActionDispatch::Http::UploadedFile
					message.content_type = guess_mime_type
					message.content = content
				else
					message.content_type = if content.match(/\A\w+:/) && !content.match(/ /)
						'text/x-hyperlink'
					else
						'text/plain'
					end
					tempfile = Tempfile.new(SecureRandom.uuid)
					tempfile.write content
					tempfile.close
					message.content = open tempfile.path
				end
				message.save!
				tempfile.try(:unlink)
				message.deliver
				render nothing: true, status: :created
			end

			private

			def message_params
				params.require(:message).permit(:content)
			end

			def guess_mime_type
				@fm ||= FileMagic.new FileMagic::MAGIC_MIME
				@fm.file(message_params["content"].tempfile.path)
			end

		end
	end
end
