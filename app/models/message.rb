class Message < ActiveRecord::Base
	validates_presence_of :content

	belongs_to :creator, class_name: 'Device'
	has_one :group, through: :creator

	def recipients
		group.devices - [creator]
	end

	def deliver
		recipients.each { |r| r.notify(content) }
	end
end
