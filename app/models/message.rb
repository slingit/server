class Message < ActiveRecord::Base
	validates_presence_of :content_type

	do_not_validate_attachment_file_type :content
	attr_accessor :content_file_name
	has_attached_file :content,
		url: "/api/v1/messages/:id/content",
		path: "/:rails_root/public/uploads/messages/:id/content"

	belongs_to :creator, class_name: 'Device'
	has_one :group, through: :creator

	def recipients
		group.devices - [creator]
	end

	def deliver
		puts "delivering method"
		recipients.each { |r| puts r.id; r.notify(id) }
	end
end
