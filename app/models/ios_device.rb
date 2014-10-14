class IosDevice < AppleDevice
	def notify(content)
		puts "NOTIFY IOS #{content}"
	end
end