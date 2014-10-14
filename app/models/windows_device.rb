class WindowsDevice < Device
	def notify(content)
		puts "NOTIFY WINDOWS #{content.inspect}"
		RestClient.post("http://178.62.49.201:4235/api/v1/notifications", { device_id: id, data: content })
	end
end