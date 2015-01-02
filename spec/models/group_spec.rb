require 'rails_helper'

RSpec.describe Group, :type => :model do
  it { is_expected.not_to respond_to :save }

  it "has an id" do
    id = SecureRandom.uuid
    group = Group.new(id: id)
    expect(group.id).to eq id
  end

  it "finds devices" do
    device = FactoryGirl.create(:device)
    group = Group.new(id: device.group_id)
    expect(group.devices).to include device
    Device.where(group_id: group.id).destroy_all
    expect(group.devices.reload).to be_empty
  end
end
