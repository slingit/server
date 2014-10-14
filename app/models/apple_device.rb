class AppleDevice < Device
	cattr_accessor :cert_path

	def notify(content)
		puts "NOTIFY APPLE #{content.inspect}"
		notification = Houston::Notification.new(device: token)
		notification.alert = content
		apn.push(notification)
	end

	private

	def apn
		@@apn ||= begin
			apn = Houston::Client.development
			apn.certificate = File.read(self.class.cert_path)
			apn
		end
	end
end
