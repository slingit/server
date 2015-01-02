require 'rails_helper'

RSpec.describe Device, :type => :model do
  it "stores secrets" do
    secret = "abc123"
    device = Device.create!(secret: secret)
    device.reload
    expect(device).to be_valid_secret secret
  end
end
