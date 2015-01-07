require "rails_helper"

RSpec.describe "devices/index.json.rabl", type: :view do
  let!(:devices) { [create(:device), create(:device_with_group)] }

  before do
    assign :devices, devices
    render
  end

  let!(:json) { JSON.parse(rendered).with_indifferent_access }

  it "renders correct information" do
    expect(json[:devices][0][:id]).to eq devices[0].id
    expect(json[:devices][0][:links][:group]).to be_nil
    expect(json[:devices][1][:id]).to eq devices[1].id
    expect(json[:devices][1][:links][:group][:id]).to eq devices[1].group_id
    expect(json[:devices][1][:links][:group][:type]).to eq "groups"
  end
end
