require 'rails_helper'

RSpec.describe Device, :type => :model do
  it "stores secrets" do
    secret = "abc123"
    device = Device.create!(secret: secret)
    device.reload
    expect(device).to be_valid_secret secret
  end

  describe "#group" do
    it "uses group_id" do
      device = Device.new
      2.times do
        id = SecureRandom.uuid
        device.group_id = id
        expect(device.group.id).to eq id
      end
    end
  end
end
