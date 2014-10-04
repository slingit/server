class AppleDevice < Device
	def notify(content)
		notification = Houston::Notification.new(device: token)
		notification.alert = content
		apn.push(notification)
	end

	private

	def apn
		@@apn ||= begin
			apn = Houston::Client.development
			apn.certificate = File.read(Rails.root.join("config/apple.pem"))
			apn
		end
	end
end