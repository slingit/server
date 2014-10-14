class Device < ActiveRecord::Base
	before_create :notify_group

	validates_presence_of :group_id, :token, :type
	validates :type, inclusion: {
		in: %w[OsxDevice IosDevice GoogleDevice WindowsDevice],
		message: "%{value} is not a valid device type"
	}

	belongs_to :group
	has_many :messages, foreign_key: :creator_id

	private

	def notify_group
		if group
			group.devices.each do |device|
				device.notify("")
			end
		end
	end
end
