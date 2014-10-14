class OsxDevice < AppleDevice
	self.cert_path = ENV["MAC_PUSH_CERT_PATH"]
end
