class GoogleDevice < Device
	def notify(content)
		puts "NOTIFY GCM #{content.inspect}"
		gcm = GCM.new(ENV["GCM_API_KEY"])
		gcm.send([token], data: { title: content })
	end
end