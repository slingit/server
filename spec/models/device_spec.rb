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

  describe "#group=" do
    it "sets group_id" do
      device = Device.new
      group = FactoryGirl.build(:group)
      device.group = group
      expect(device.group_id).to eq group.id
    end
  end
end
