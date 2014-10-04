class Device < ActiveRecord::Base
	validates_presence_of :group_id, :token, :type
	validates :type, inclusion: {
		in: %w[AppleDevice GoogleDevice],
		message: "%{value} is not a valid device type"
	}

	belongs_to :group
	has_many :messages, foreign_key: :creator_id
end
